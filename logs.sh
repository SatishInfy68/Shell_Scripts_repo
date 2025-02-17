USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d:%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

echo "Script is started at: $TIMESTAMP" &>>$LOG_FILE_NAME

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

dnf list installed git* &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
    dnf install git* -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing GIT"
else
    echo -e "GIT is already...$Y INSTALLED"
fi

dnf list installed mariadb* &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then 
    dnf install mariadb* -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MARIADB"
else
    echo -e "MARIADB is already...$Y INSTALLED"
fi