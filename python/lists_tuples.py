#Lists and Tuples

#Lists
#Lists are mutable, meaning that you can change the values of the elements in a list after the list has been created.
#Lists are created by placing all the items (elements) inside square brackets [], separated by commas.
#It is possible to have a list with no elements, which is called an empty list.
#Lists are ordered, meaning that the items have a defined order, and that order will not change.
#Lists allow duplicate values.
#Lists are changeable, meaning that we can change, add, and remove items in a list after it has been created.
#List items are indexed, the first item has index [0], the second item has index [1] etc.
#List items are ordered, changeable, and allow duplicate values.
#List items are indexed, the first item has index [0], the second item has index [1] etc.
#When we say that lists are ordered, it means that the items have a defined order, and that order will not change.


fruit = ["apple", "banana", "cherry"]
mixlist = ["apple", 1, 2, 3, "banana", 4, 5, "cherry", 6, 7, 8]
print(fruit)
print(mixlist)
#Output: ['apple', 'banana', 'cherry']
#Output: ['apple', 1, 2, 3, 'banana', 4, 5, 'cherry', 6, 7, 8]

print(fruit[2])

fruit[1] = "blackcurrant"
print(fruit)

# list methods
# append()	Adds an element at the end of the list
# clear()	Removes all the elements from the list
# copy()	Returns a copy of the list
# count()	Returns the number of elements with the specified value in the list
# extend()	Add the elements of a list (or any iterable), to the end of the current list
# index()	Returns the index of the first element with the specified value
# insert()	Adds an element at the specified position
# pop()	Removes the element at the specified position
# remove()	Removes the first item with the specified value
# reverse()	Reverses the order of the list
# sort()	Sorts the list in ascending order
