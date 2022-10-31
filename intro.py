# objects
new_object=2
object='ABCD 1 5 2'
object=[1,5,6, 1/6, 'A']
object2=(4.0,object, 'A')

# calculations
5+5
5**5
a=600
b=7
a+b
a**b

# functions
def my_function(input):
  for x in input:
  output=x**5
print(output)

my_function(object)

# reading & writing
testfile = open("fileA.txt", "r")print(testfile.read()) 
print(testfile.readline()) 
testfile.close() 

newfile = open("fileF.txt", "x")
newfile.write(testfile)
f.close()


