## when to use function composition
when a function must perform **two** or more distinct operations on the consumed data
## when to use helpers
1. If a subtask requires operating on arbitrary sized data
2. If a subtask involves special domain knowledge
	- for example: if we are designing a function for strings and then we need to design a function for numbers
	- or in the arrange images exercise, inserting image in a list of images in increasing order of size is in a domain different from evaluating if an image is bigger than another
1. 1. Keep the "one task per function" goal in mind. If part of a function you are designing seems to be a well-defined subtask use a helper.
