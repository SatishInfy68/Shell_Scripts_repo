USERID=$(id -u)

if [ $USERID -ne 0 ]
then
        echo "Error: you must have the access to run script"

fi

dnf install mysql -y
dnf install git -y