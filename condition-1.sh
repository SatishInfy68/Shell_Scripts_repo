USERID=$(id -u)

if [ $USERID -ne 0 ]
then
        echo "Error: you must have the access to run script"
        exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    dnf install mysql

    if [ $? -ne 0 ]
    then
        echo "Installaton: Failed"
        exit 1
    else
        echo "Installation: Success"
    fi

else
    echo "Installaton is already done"
fi

dnf list installed git

if [ $? -ne 0 ]
then 
    dnf install git -y

    if [ $? -ne 0 ]
    then
        echo "Installaton: Failed"
        exit 1
    else
        echo "Installation: Success"
    fi

else
    echo "Git is already installed"
fi