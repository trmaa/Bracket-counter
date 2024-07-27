#include <iostream>
#include <string>
#include <vector>

const std::string opening = "{[(<";
const std::string ending = "}])>";

bool is_in(const char& l1, const std::string& lizt) {
	for (const char& l2: lizt)
		if (l1 == l2)
			return true;
	return false;
}

int main() {
	std::string chain;
	std::cout << "Your code in here: ";
	std::cin >> chain;

	int openings = 0;
	std::vector<int> index;

	int seen = 0;
	for (char& c: chain) {
		seen += 1;

		bool c_op = is_in(c, opening);
		bool c_ed = is_in(c, ending);
		
		if (c_op) {
			openings += 1;
			index.push_back(opening.find(c));
		}
		if (c_ed) {
			if (openings < 1 || index[index.size()-1] != ending.find(c)) {
				std::cout << "Bad!!" << std::endl;
				return 0;
			}
			openings -= 1;
			index.pop_back();
		}

		std::cout << c << " " << 100*seen/chain.size() << "%" << std::endl;
	}

	if (openings != 0) {
		std::cout << "Bad!!" << std::endl;
		return 0;
	}

	std::cout << "Good!!" << std::endl;
}
