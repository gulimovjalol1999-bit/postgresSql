//1
type Car = { make: string; model: string; year: number };

function getCarModels(cars: Car[]): string[] {
 return cars.map(car => car.model) 
}

//2
function isValidSudoku(board: number[][]): boolean {
  const rows = new Set<string>();
  const cols = new Set<string>();
  const boxes = new Set<string>();

  for (let i = 0; i < 9; i++) {
    for (let j = 0; j < 9; j++) {
      const num = board[i][j];

      if (num === 0) continue;

      const rowKey = `${i}-${num}`;
      const colKey = `${j}-${num}`;
      const boxKey = `${Math.floor(i / 3)}-${Math.floor(j / 3)}-${num}`;

      if (rows.has(rowKey) || cols.has(colKey) || boxes.has(boxKey)) {
        return false;
      }

      rows.add(rowKey);
      cols.add(colKey);
      boxes.add(boxKey);
    }
  }

  return true;
}

//3
function tupleToObject(
  arr: [string, number, string]
): { name: string; age: number; job: string } {

  return {
    name: arr[0],
    age: arr[1],
    job: arr[2]
  };
}

//4
function addBook(books: Book[], newBook: Book): string[] {
  const updatedBooks = [...books, newBook];
  return updatedBooks.map(book => book.title);
}

//5
function jsonDiff(
  obj1: Record<string, any>,
  obj2: Record<string, any>
): object {
  const result: Record<string, any> = {};

  const keys = new Set([...Object.keys(obj1), ...Object.keys(obj2)]);

  for (let key of keys) {
    if (obj1[key] !== obj2[key]) {
      result[key] = {
        old: obj1[key],
        new: obj2[key]
      };
    }
  }

  return result;
}

//6
function fizzBuzz(n: number): string[] {
  const result: string[] = [];

  for (let i = 1; i <= n; i++) {
    if (i % 15 === 0) {
      result.push("FizzBuzz");
    } else if (i % 3 === 0) {
      result.push("Fizz");
    } else if (i % 5 === 0) {
      result.push("Buzz");
    } else {
      result.push(i.toString());
    }
  }

  return result;
}

//7
function upperCaseKeys(obj: Record<string, any>): object {
  let result: Record<string, any> = {}

  for(let key in obj) {
    if(obj.hasOwnProperty(key)) {
      result[key.toUpperCase()] = obj[key]
    }
  }
  return result
}

//8
function safeValue(val?: string | null): string {
  if(val === null || undefined) {
    return "default"
  }else {
    return val
  }
}

//9
function sortIPs(ips: string[]): string[] {
  return ips.sort((a, b) => {
    const octetsA = a.split('.').map(Number);
    const octetsB = b.split('.').map(Number);

    for (let i = 0; i < 4; i++) {
      if (octetsA[i] !== octetsB[i]) {
        return octetsA[i] - octetsB[i];
      }
    }

    return 0;
  });
}

//10
function checkValue(val: string | number): number {
  

  if(typeof val === "string") {
    return val.length
  }else if(typeof val === "number") {
    return val * 2
  }
}

//11
function sumArray(arr: number[]): number {
  let sum:number = 0

  for(let num of arr) {
    sum += num
  }
  return sum    
}

//12
function stringLengths(arr: string[]): number[] {
  return arr.map(str => str.length)
}

//13
function compressString(str: string): string {
  if (str.length === 0) return "";

  let result = "";
  let count = 1;

  for (let i = 1; i < str.length; i++) {
    if (str[i] === str[i - 1]) {
      count++;
    } else {
      result += str[i - 1] + count;
      count = 1;
    }
  }

  // oxirgi guruhni qo‘shish
  result += str[str.length - 1] + count;

  return result;
}

//14
function getPermutations(str: string): string[] {
  const arr = str.split("");
  const result: string[] = [];
  const n = arr.length;
  const c = new Array(n).fill(0);

  result.push(arr.join(""));

  let i = 0;
  while (i < n) {
    if (c[i] < i) {
      if (i % 2 === 0) {
        [arr[0], arr[i]] = [arr[i], arr[0]];
      } else {
        [arr[c[i]], arr[i]] = [arr[i], arr[c[i]]];
      }

      result.push(arr.join(""));
      c[i]++;
      i = 0;
    } else {
      c[i] = 0;
      i++;
    }
  }

  return result;
}

//15
function groupAnagrams(words: string[]): string[][] {
  const map: Record<string, string[]> = {};

  for (const word of words) {
    const key = word.split("").sort().join("");

    if (!map[key]) {
      map[key] = [];
    }

    map[key].push(word);
  }

  return Object.values(map);
}