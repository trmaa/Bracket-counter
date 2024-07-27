OPENING: str = "{[(<"
ENDING: str = "}])>"

chain: str = input("Your code in here: ")

openings: int = 0
index: list = []

seen: int = 0
for c in chain:
    seen += 1

    c_op: bool = c in OPENING
    c_ed: bool = c in ENDING

    if c_op:
        openings += 1
        index.append(OPENING.find(c))

    if c_ed:
        if openings < 1 or index[-1] != ENDING.find(c):
            print("Bad!!")
            exit()
        openings -= 1
        index.pop()

    print(f"{c} {100*seen/len(chain)}%")

if openings != 0:
    print("Bad!!")
    exit()

print("Good!!")
