# Python中十进制与不同进制数据之间的转换总结

	二进制：0b
	八进制:0o
	十六进制:0x
	
	内建函数：
	'bin': <built-in function bin>,				# 将一个整数转换为一个二进制字符串
	'oct': <built-in function oct>,				# 将一个整数转换为一个八进制字符串
	'hex': <built-in function hex>,				# 将一个整数转换为一个十六进制字符串

	# 将十进制转换为其他进制的字符串，注意：转换的结果是字符串
	In [1]: bin(20)
	Out[1]: '0b10100'
	
	In [2]: oct(20)
	Out[2]: '0o24'
	
	In [3]: hex(20)
	Out[3]: '0x14'

	# 将其他进制的整数转换为十进制整数
	In [4]: int(0b10100)
	Out[4]: 20
	
	In [5]: int(0o24)
	Out[5]: 20
	
	In [6]: int(0x14)
	Out[6]: 20
		
	# 将其他进制的字符串转换为十进制整数
	In [7]: int('0b10100', base=2)
	Out[7]: 20
	
	In [8]: int('0o24', base=8)
	Out[8]: 20
	
	In [9]: int('0x14', base=16)
	Out[9]: 20
	
	当base=0时，表示将字符串作为一个整数:
	In [10]: int('0b10100', base=0)	# 等价于int(0b10100)
	Out[10]: 20
	
	In [11]: int('0o24', base=0)	# 等价于int(0o24)
	Out[11]: 20
	
	In [12]: int('0x14', base=0)	# 等价于int(0x14)
	Out[12]: 20

	>>> help(int)
	Help on class int in module builtins:
	
	class int(object)
	 |  int(x=0) -> integer
	 |  int(x, base=10) -> integer
	 |
	 |  Convert a number or string to an integer, or return 0 if no arguments
	 |  are given.  If x is a number, return x.__int__().  For floating point
	 |  numbers, this truncates towards zero.
	 |
	 |  If x is not a number or if base is given, then x must be a string,
	 |  bytes, or bytearray instance representing an integer literal in the
	 |  given base.  The literal can be preceded by '+' or '-' and be surrounded
	 |  by whitespace.  The base defaults to 10.  Valid bases are 0 and 2-36.
	 |  Base 0 means to interpret the base from the string as an integer literal.