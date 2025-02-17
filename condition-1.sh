USERID=$(id -u)

if [ $USERID -ne 0 ]
then
        echo "Error: you must have the access to run script"
        exit 1
fi

dnf install mysql -y
dnf install git -y