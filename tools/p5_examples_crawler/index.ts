import * as puppeteer from 'puppeteer';
const { executablePath } = require('puppeteer');
var beautify = require('js-beautify/js').js;
import fs from "fs-extra";

interface ExampleData {
  name: string;
  description: string;
  code: string;
}

interface ExampleGroup {
  groupName: string;
  examples: ExampleData[];
}

interface ExampleGroupData {
  groupName: string;
  href: string[];
}

const baseUrl = 'https://p5js.org/examples';

(async () => {
  const browser = await puppeteer.launch({
    executablePath: executablePath(),
  });
  const page = await browser.newPage();

  await page.goto(baseUrl);
  await page.setViewport({ width: 1080, height: 1024 });
  const groupSelector = '#examples-page';
  await page.waitForSelector(groupSelector);
  const res1 = await parseColumn('.column_0', page, browser);
  const res2 = await parseColumn('.column_1', page, browser);
  const res3 = await parseColumn('.column_2', page, browser);
  fs.writeFileSync('./data.json', beautify(JSON.stringify([...res1, ...res2, ...res3])));
  await browser.close();
})();

async function parseExample(href: string, browser: puppeteer.Browser): Promise<ExampleData> {
  const page = await browser.newPage();
  await page.goto(baseUrl + '/' + href);
  await page.setViewport({ width: 1080, height: 1024 });
  const groupSelector = '.ace_content';
  await page.waitForSelector(groupSelector);
  await page.waitForNetworkIdle();
  const description = await page.$eval('#example-desc', e => (e as HTMLElement).innerText);
  const textLayer = await page.$('.ace_text-layer');
  const name = await page.$eval('#example-name', e => (e as HTMLElement).innerText);
  // if (name == 'example name placeholder') {

  // }
  const code = await textLayer!.$$eval('span', e => e.map(e => {
    let str = ' ';
    const isComment = e.className.includes('ace_comment');
    if (isComment) {
      str += '\n';
    }
    str += e.innerText;
    if (isComment) {
      str += '\n';
    }
    return str;
  }));

  return {
    name,
    description,
    code: (beautify(code.join('')) as string).replaceAll('createCanvas(720, 400)', 'createCanvas(screenWidth, screenHeight)'),
  };
}

async function parseColumn(columnName: string, page: puppeteer.Page, browser: puppeteer.Browser): Promise<ExampleGroup[]> {
  const column = await page.$(columnName);
  const headers = await column!.$$eval('h3', e => e.map(e => (e as HTMLElement).innerText));
  const paragraph = await column!.$$('p');
  let hIndex = 0;
  let groups: ExampleGroup[] = [];
  for (let i in paragraph) {
    let examples: ExampleData[] = [];
    const item = paragraph[i];
    const href = await item.$$eval('a', e => e.map(e => e.getAttribute('href')!));
    console.log(href);
    for (let j = 0; j < href.length; j++) {
      let h = href[j];
      const example = await parseExample(h, browser);
      examples.push(example);
    }
    groups.push({
      groupName: headers[hIndex],
      examples,
    });
    hIndex += 1;
  }

  return groups;
}
