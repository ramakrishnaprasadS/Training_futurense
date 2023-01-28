#!/usr/bin/env python
# coding: utf-8

# In[1]:


import psycopg2

#pip install psycopg2


# In[2]:


psycopg2.__version__


# In[15]:


hostname = 'localhost'
database='chirantandb'
username='postgres'
pwd='chirantan'
port_id='5432'
cur=None
conn=None

#this is not how we connect usually in the real life projects
# there are config files in which you get all the details for the connection
# and then just by following the logs, you can connect


# In[16]:


conn = psycopg2.connect(host=hostname,
                       dbname=database,
                       user=username,
                       password=pwd,
                       port=port_id)


# In[17]:


conn.close()

#conn.close will close the database connection 
# it will make sure what code we write,will be in betweend database connection open and database connection close commands


# In[6]:


# not try to change the hostname and see if this throws an error or not


# In[18]:


#instead preferred method is to put the connection code in try and except block

try:
    conn = psycopg2.connect(host=hostname,
                       dbname=database,
                       user=username,
                       password=pwd,
                       port=port_id)
    #create a cursor object
    cur = conn.cursor()
    #close the cursor
    
    cur.execute('DROP TABLE IF EXISTS employee_Miles')
    # every time we run the script, it will first drop the table and then insert the values
    # if we run the same script again and again it will throw error, because id is a Primary key 
    # and I cannot insert it again and again
    
    #write a script to create your table
    create_script="""CREATE TABLE IF NOT EXISTS employee_Miles(
    id int PRIMARY KEY,
    name varchar(40) NOT NULL,
    salary int,
    dept_id varchar(30))"""
    
    #in order to execute the above script, we use
    cur.execute(create_script)
    
    #we need to insert some data into the table
    insert_script='INSERT INTO employee_Miles(id,name,salary,dept_id) VALUES (%s,%s,%s,%s)'
    insert_values=[(1,'Chirantan',50000,'D1'),(2,'Ojasvee',58000,'D1'),(3,'Prakash',90000,'D2')]
    
    for record in insert_values:
        cur.execute(insert_script,record)
    
     #What if you want to update some data in the tables
    update_script = 'UPDATE employee_Miles SET salary = salary + (salary*0.5)' #increment of salary by 50%
    cur.execute(update_script)
    
    #what if you want to delete some tables from you database
    #delete_script = 'DELETE FROM employee_Miles WHERE name= %s'
    #delete_record=('Prakash',)
    #cur.execute(delete_script,delete_record)
    
    
    #Now, how do i fetch the data from my SQL database into my python notebook
    cur.execute('SELECT * FROM employee_Miles')
    for record in cur.fetchall():
        print(record)  #you can see the tuple of records, fetchall is used to get the records
        #print(record[1],record[2])
    
 
    
    # we did not specify any values in VALUES so that we can avoid SQL injection
    #instead we prefer using place holders
    
    #all the transactions that we do, we need to commit it, only then can we se that in our db
    conn.commit()
    
    #you can see after this by going to pgadmin that the table is created
    # and having the columns we wanted
    
except Exception as error:
    print(error)
finally: #finally block will execute no matter what the condition is 
    if cur is not None: #means the cursor was open, if the cursor is open only then close it
        cur.close()
    if conn is not None: #means the connection was open, if the connection is open only then close it
        conn.close()
  
    


# In[ ]:


#in order to perform any database transactions
# we need to open a cursor
# cursor will help you perform SQL operations and also store the values returned from the operations


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




