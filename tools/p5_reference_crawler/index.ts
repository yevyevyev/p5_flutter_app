import * as puppeteer from 'puppeteer';
var beautify = require('js-beautify/js').js
const { executablePath } = require('puppeteer');
import fs from "fs-extra";

interface ReferenceTokenParam {
  paramName: string;
  paramType: string;
  paramDescription: string;
}

interface ReferenceToken {
  label: string;
  description: string;
  examples: string[];
  href: string;
  syntax: string[];
  returns: string | null;
  parameters: ReferenceTokenParam[];
}

interface ReferenceSubgroup {
  subgroupName: string | undefined;
  tokens: ReferenceToken[];
}

interface ReferenceGroup {
  groupName: string | undefined;
  subgroups: ReferenceSubgroup[];
}

const baseUrl = 'https://p5js.org/reference';

(async () => {
  // fs.readFile('data.json', 'utf8', function (err, data) {
  //   if (err) {
  //     throw err;
  //   }
  //   fs.writeFileSync('./data2.json', beautify(data, { indent_size: 2, space_in_empty_paren: true }));
  // });
  // return;
  const browser = await puppeteer.launch({
    executablePath: executablePath(),
  });
  const page = await browser.newPage();

  await page.goto(baseUrl);
  await page.setViewport({ width: 1080, height: 1024 });
  const groupSelector = '#list div.reference-group';
  await page.waitForSelector(groupSelector);
  await page.evaluate(() => {
    window.scrollBy(0, window.innerHeight * 3);
  });

  const groups = await page.$$(groupSelector);
  let parsedGroups: ReferenceGroup[] = [];
  for (let index in groups) {
    const group = groups[index];
    const groupName = await (await group.$('.group-name'))?.evaluate((p) => p.innerHTML);
    console.log(groupName);
    const subgroups = await group.$$('.reference-subgroup');
    let parsedSubgroups: ReferenceSubgroup[] = [];
    for (let sIndex in subgroups) {
      const subgroup = subgroups[sIndex];
      const subgroupName = await (await subgroup.$('.subgroup-name'))?.evaluate((p) => p.innerHTML);
      console.log(subgroupName);

      const tokens = await subgroup.$$('li');
      let parsedTokens: ReferenceToken[] = [];
      for (let tIndex in tokens) {
        const token = tokens[tIndex];
        const tokenName = await token.evaluate((t) => t.textContent);
        const href = await token.$eval('a', (a => a.getAttribute('href')));
        const parsedToken = await fetchReferenceToken(browser, href!, tokenName!);
        parsedTokens.push(parsedToken);
      }

      parsedSubgroups.push({
        subgroupName,
        tokens: parsedTokens,
      });
    }

    parsedGroups.push({
      groupName,
      subgroups: parsedSubgroups,
    });
  }

  fs.writeFileSync('./p5_reference.json', beautify(JSON.stringify(parsedGroups)));
  await browser.close();
})();

async function fetchReferenceToken(browser: puppeteer.Browser, href: string, label: string): Promise<ReferenceToken> {
  const page = await browser.newPage();
  await page.goto(baseUrl + href);
  await page.waitForSelector('.description');
  let description = '';
  let returns: string | null = null;

  try {
    const d = await page.$('.description-text');
    description = await d!.$$eval('p', p => p.map(p => p.innerText).join('\n'));
  } catch (_) { }
  let syntax: string[] = [];
  try {
    const div = await page.$('.syntax');
    syntax = await div!.$$eval('pre', p => p.map(p => p.innerText));
  } catch (_) { }

  try {
    returns = await page.$eval('.returns', p => {
      let content = '';
      for (let i = 0; i < p.childNodes.length; i++) {
        content += p.childNodes[i].textContent;
      }
      return content
    });
  } catch (_) { }

  let exampleCodes: string[] = [];

  try {
    const examples = await page.$$('.example_container');
    for (let eIndex in examples) {
      const example = examples[eIndex];
      const code = await example.$('code');

      let exampleCode = await code!.evaluate(c => {
        let s = '';
        for (let i = 0; i < c.childNodes.length; i++) {
          if (c.childNodes.item(i) instanceof HTMLElement) {
            const child = c.childNodes.item(i) as HTMLElement;
            const isComment = child.className.includes('comment');
            if (isComment) {
              s += '\n';
            }
            s += child.innerText + ' ';
            if (isComment) {
              s += '\n';
            }
          } else {
            s += c.childNodes.item(i).textContent;
          }
        }
        return s;
      });
      exampleCodes.push(beautify(exampleCode));
    }
  } catch (_) {
    console.log('failed example codes');
  }

  let referenceTokenParams: ReferenceTokenParam[] = [];
  try {
    const params = await page.$$('.params li');
    for (let pIndex in params) {
      const param = params[pIndex];
      const paramType = await param.$eval('.param-type', p => (p as HTMLElement).innerText);
      let paramDescription = '';
      try {
        paramDescription = await param.$eval('p', p => p.innerText);
      } catch (_) { }
      const paramName = await param.$eval('.paramname', p => p.innerHTML);
      referenceTokenParams.push({
        paramType: paramType,
        paramDescription: paramDescription,
        paramName: paramName,
      });
    }
  } catch (_) {
    console.log('failed token parsing');
  }

  return {
    label: label,
    description,
    examples: exampleCodes,
    href,
    syntax,
    returns,
    parameters: referenceTokenParams,
  };
}