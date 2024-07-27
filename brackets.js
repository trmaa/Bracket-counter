import * as readline from 'readline';

const opening = "{[(<";
const ending = "}])>";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main(chain) {
    let openings = 0;
    const index = [];
    let seen = 0;

    for (const c of chain) {
        seen++;

        const c_op = opening.includes(c);
        const c_ed = ending.includes(c);

        if (c_op) {
            openings++;
            index.push(opening.indexOf(c));
        }

        if (c_ed) {
            if (openings < 1 || index[index.length - 1] !== ending.indexOf(c)) {
                console.log("Bad!!");
                rl.close();
                return;
            }
            openings--;
            index.pop();
        }

        console.log(`${c} ${(100 * seen / chain.length).toFixed(2)}%`);
    }

    if (openings !== 0) {
        console.log("Bad!!");
    } else {
        console.log("Good!!");
    }

    rl.close();
}

rl.question('Your code in here: ', main);
