filename1="C:\\Users\\miles\\Documents\\GitHub\\Training_futurense\\Python\\file1.txt"
filename2="C:\\Users\\miles\\Documents\\GitHub\\Training_futurense\\Python\\file2.txt"
try:
    f=open(filename1,'r')
    d=f.read()
    print(d)
    #a=4/0
    f.close()
except FileNotFoundError as fnf:
    print("the file \n"+filename1+"  \nis not available")
    try:
        f=open(filename2,'r')
        d=f.read()
        print("file opened from alternate location "+filename2)
        print(d)
        f.close()
    except FileNotFoundError as fnf2:
        print("file not found in alternate location also")
    except Exception:
        print("unexpected error 2")
    
except Exception as e:
    print("Unexpected Error1  is "+str(e))
finally:
    f.close()
    
