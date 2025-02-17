USERID=$(id -u)

if [ $USERID -ne 0 ]
then
        echo "Error: you must have the access to run script"
        exit 1
fi

dnf install mysql -y

if [ $? -ne 0 ]
then 
    echo "Installaton: Failed"
    exit 1
else
    echo "Installation: Success"
fi

dnf install git -y

if [ $? -ne 0 ]
then 
    echo "Installaton: Failed"
    exit 1
else
    echo "Installation: Success"
fi