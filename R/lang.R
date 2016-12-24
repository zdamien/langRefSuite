x=1:3 # 1 2 3
x=3:1 # 1 2 3
x=seq(1,3)
x=seq(1,3,2) # 1 3
x=1:3 # 1 2 3
x-1 # 0 1 2
x*2 # 2 4 6
x=c(3,1,2)
y=rep(x,2) # 3 1 2 3 1 2
x<2 # FALSE TRUE FALSE
F #FALSE
is.na(x)
is.nan(x)
paste(4) # "4"
paste(x) # [1] "3" "1" "2"
x[x<2] # 1
x[-2] # 3 2
x[0] #no
x[1] # 1-indexed, not 0-indexed

fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
lunch <- fruit[c("apple","orange")]

#%mul% = function(x,y) x*y
#Error: unexpected SPECIAL in "%mul%"
"%mul%" = function(x,y) x*y
3 %mul% 4 # [1] 12

id=function(x=0) x
id
#function(x=0) x
id()
#[1] 0
id(4)
#[1] 4


