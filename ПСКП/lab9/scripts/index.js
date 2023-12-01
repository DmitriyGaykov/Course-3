export function dateMapperFromString(date) {
  return new Date(date);
}

export function fib([n]) {
  const seq = [];

  for (let i = 0; i < n; i++) {
    if (i < 2) seq.push(i);
    else seq.push(seq[i - 1] + seq[i - 2]);
  }

  console.log(seq);

  return seq;
}

export function fact([n]) {
  if (n < 2) return 1;
  return n * fact([n - 1]);
}

export function square(args) {
  if (args.length === 1) return Math.PI * args[0] ** 2;
  return args[0] * args[1];
}

export function sum(params) {
  return params.reduce((acc, cur) => acc + cur, 0);
}
export function mul(params) {
  return params.reduce((acc, cur) => acc * cur, 1);
}
