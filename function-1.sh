USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failed"
        exit 1
    else
        echo -e "$2...$G Success"
    fi
}


if [ $USERID -ne 0 ]
then
        echo "Error: you must have the access to run script"
        exit 1
fi

dnf list installed git*
if [ $? -ne 0 ]
then
    dnf install git* -y
    VALIDATE $? "Installing GIT"
else
    echo -e "GIT is already...$Y INSTALLED"
fi

dnf list installed mysql*

if [ $? -ne 0 ]
then 
    dnf install git -y
    VALIDATE $1 "Installing MySQL"
else
    echo -e "Git is already...$Y INSTALLED"
fi