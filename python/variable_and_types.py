
a = 1
b = 2
print(a+b)

name = "Ahmed"
print(name)

#DataTypes
#int
#float
#str
#bool
#list
#tuple
#dict
#set
#none

#int
a = 1 #a is an integer
print(a)
#float
b = 1.0 #b is a float
print(b)
#str
name = "Ahmed" #name is a string
print(name)
#bool
is_true = True #is_true is a boolean
print(is_true)
#list
#list explanatiion:
#List is a collection which is ordered and changeable. Allows duplicate members.
#In Python lists are written with square brackets.
#list is mutable
#list is ordered
#list is changeable
#list allows duplicate members
#list is dynamic
#list is heterogenous
#list is indexable
#list is sliceable
#list is iterable
#add elements to list give example

my_list = [1,2,3,4,5] #my_list is a list
print(my_list)
#add elements to list
my_list.append(6)
print(my_list)


#list functions
#append
#insert explanation : insert() method inserts an element to the list at the specified index.
#insert() method takes two parameters: the element to be inserted and the index at which the element
#has to be inserted. All the elements after the inserted element are shifted to the right.
#extend explanation : extend() method adds elements to the end of the list. It can take any iterable as an argument.
example_list = [1,2,3,4,5]
example_list.insert(2, 6)
print(example_list)
#remove explanation : remove() method removes the first occurrence of the element with the specified value.
#remove() method takes a single element as an argument and removes it from the list.
example_list.remove(6)
print(example_list)

#pop explanation : pop() method removes the element at the specified index and returns it.
#pop() method takes a single argument (index) and removes the element present at that index from the list.
#If the index passed to the pop() method is not in the range, it throws IndexError: pop index out of range exception.
example_list.pop(2)
print(example_list)

#clear explanation : clear() method removes all the elements from the list.
#clear() method does not take any arguments.
example_list.clear()

#copy explanation : copy() method returns a shallow copy of the list.
#copy() method does not take any arguments.
example_list = [1,2,3,4,5]
example_list2 = example_list.copy()
print(example_list2)
#count explanation : count() method returns the number of occurrences of the specified element in the list.
#count() method takes a single argument and returns the number of times the specified element appears in the list.
example_list = [1,2,3,4,5,1,2,3,4,5]
print(example_list.count(1))

#extend explanation : extend() method adds elements to the end of the list. It can take any iterable as an argument.
example_list = [1,2,3,4,5]
example_list.extend([6,7,8,9,10])
print(example_list)

#index explanation : index() method returns the index of the specified element in the list.
#index() method takes a single argument and returns the index of the first occurrence of the specified element in the list.
example_list = [1,2,3,4,5]
print(example_list.index(3))

#reverse explanation : reverse() method reverses the elements of the list.
#reverse() method does not return any value but reverse the given object from the list.
example_list = [1,2,3,4,5]
example_list.reverse()
print(example_list)

#sort explanation : sort() method sorts the elements of a given list in a specific ascending or descending order.
#sort() method does not return any value but it changes from the original list.
example_list = [5,2,3,4,1]
example_list.sort()
print(example_list)



#remove elements from list

my_list = [1,2,3,4,5] #my_list is a list
print(my_list)
#tuple
#tuple explanatiion:
#tuple is a collection which is ordered and unchangeable. Allows duplicate members.
#In Python tuples are written with round brackets.
#tuple is immutable
#tuple is ordered
#tuple allows duplicate members
#tuple is dynamic
#tuple is heterogenous
#tuple is indexable
#example of indexable: my_tuple[0]
my_tuple = (1,2,3,4,5) #my_tuple is a tuple
print(my_tuple)

#tuple is sliceable
#tuple is iterable example
#example of iterable:
my_tuple = (1,2,3,4,5) #my_tuple is a tuple
for i in my_tuple:
    print(i)

my_tuple = (1,2,3,4,5) #my_tuple is a tuple
print(my_tuple)
#dict
my_dict = {"name":"Ahmed","age":25} #my_dict is a dictionary
print(my_dict)
#set
my_set = {1,2,3,4,5} #my_set is a set
print(my_set)
#none
my_none = None #my_none is None
print(my_none)


b = 6
b += 3
print(b)


#comparison operators
# == equal
# != not equal
# > greater than
# < less than
# >= greater than or equal
# <= less than or equal
#equality operator
a = 1
b = 2
print(a == b)
print(a != b)
print(a > b)
print(a < b)
print(a >= b)
print(a <= b)

#logical operators
# and
# or
# not
a = 1
b = 2
c = 3
print(a < b and b < c)


# remainder
a = 32
b= 5
print("remainder is ", a % b)

a = int(input('enter number 1 : '))
b = int(input('enter number 2 : '))
print("average is ", (a+b)/2)


a = int(input('enter number 1 : '))
print("square of a is :" , a**2)



#dictionary

my_dict = {"name":"Ahmed","age":25} #my_dict is a dictionary
print(my_dict)
#add elements to dictionary
my_dict["city"]="Cairo"
print(my_dict)
#update elements in dictionary
my_dict["city"]="Alex"
print(my_dict)
#remove elements from dictionary
my_dict.pop("city")
print(my_dict)
#clear dictionary
my_dict.clear()
print(my_dict)
#copy dictionary
my_dict = {"name":"Ahmed","age":25} #my_dict is a dictionary
my_dict2 = my_dict.copy()
print(my_dict2)
#access elements in dictionary
print(my_dict["name"])
#check if key exists in dictionary
print("name" in my_dict)
#dictionary functions
#clear explanation : clear() method removes all the elements from the dictionary.
#clear() method does not take any arguments.
#clear() method does not return any value.
my_dict = {"name":"Ahmed","age":25} #my_dict is a dictionary
my_dict.clear()
print(my_dict)
