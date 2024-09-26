<?php
session_start();
//require_once('Models/UserData.php');
require_once('Models/Database.php');

class User
{
    protected $_dbHandle, $_dbInstance;
    protected $reqNumber;
    protected $oldNum;

    public function __construct()
    {
        $this->_dbInstance = Database::getInstance();
        $this->_dbHandle = $this->_dbInstance->getdbConnection();
    }

    public function createUsers($FirstName, $LastName, $email, $DoB, $gender, $pwd)
    {

        $checkEmail = $this->_dbHandle->prepare("SELECT * FROM `user` WHERE email = ?");
        $checkEmail->execute([$email]);
        if ($checkEmail->rowCount() > 0) {
            return 2;
        } else {
            if (empty($gender)) {
                $gender = 'Prefer Not To Say';
            }
            $hashPassword = password_hash($pwd, PASSWORD_DEFAULT);
            $sqlQuery = "INSERT INTO user (first_name, last_name, password, DoB, email, gender) VALUE (?, ?, ?, ?, ?, ?)";
            $statement = $this->_dbHandle->prepare($sqlQuery);
            $statement->bindParam(1, $FirstName);
            $statement->bindParam(2, $LastName);
            $statement->bindParam(3, $hashPassword);
            $statement->bindParam(4, $DoB);
            $statement->bindParam(5, $email);
            $statement->bindParam(6, $gender);
            $statement->execute();
            return 1;
        }
    }
    public function loginUser($email, $password)
    {
        $email = trim($email);
        $password = trim($password);
        $checkEmail = $this->_dbHandle->prepare("SELECT * FROM user WHERE email = ? ");
        $checkEmail->execute([$email]);
        $row = $checkEmail->fetch(PDO::FETCH_ASSOC);
        $rowCount = $checkEmail->rowCount();
        //echo $rowCount;
        if ($rowCount === 1) {
            $verifyPass = password_verify($password, $row['password']);
            if ($verifyPass) {
                //$_SESSION["login"] = $row['id'];
                $_SESSION = [
                    'user_id' => $row['id'],
                    'email' => $row['email']
                ];
                header('Location: dashboard.php');
            } else {
                //echo '<h1 class="p-3 mb-2 bg-danger text-white"><br>Show password not matched message!<br></h1>';
                return 1; //error pass
            }
        } else {
            //echo '<h1 class="p-3 mb-2 bg-danger text-white"><br> Show Email is not registered message!<br></h1>';
            return 2; //error email
        }
    }
    public function getSession()
    {
        //var_dump($_SESSION);
        //echo '<h1>Logged in via email:' . $_SESSION['email'];
        return $_SESSION;
    }
    public function countExperiment()
    {
        try {
            $sql = "SELECT * FROM `experiment`";
            $stmt = $this->_dbHandle->prepare($sql);
            $stmt->execute();
            //fetch all rows as an object
            $allRecieved = $stmt->fetchAll(PDO::FETCH_OBJ);
            //echo '<pre>' , var_dump($allRecieved) , '</pre>';
            //echo '<prev>',var_dump($allRequests),'</prev>';
            $this->reqNumber = count((array)$allRecieved);

            $sqlTwo = "SELECT totalExperiments FROM `notification` WHERE id=1";
            $stmtTwo = $this->_dbHandle->prepare($sqlTwo);
            $stmtTwo->execute();
            //fetch all rows as an object
            //$allRecievedExp = $stmtTwo->fetchAll(PDO::FETCH_OBJ);
            $allRecievedExp = $stmtTwo->fetch(PDO::FETCH_ASSOC);
            //echo '<pre>' , var_dump($allRecievedExp) , '</pre>';
            //$reqNumberTwo = count((array)$allRecievedExp);
            //echo '<prev>',var_dump($allRecievedExp['totalExperiments']),'</prev>';
            //$this->oldNum = intval($allRecievedExp['totalExperiments']);
            if ($this->oldNum < $this->reqNumber) {
                //echo '<prev>',var_dump($reqNumber),'</prev>';
                //echo var_dump($oldNum);
                //echo "New Notification";
                $notificationNumber = $this->reqNumber - $this->oldNum;
                //echo $notificationNumber;
                return $notificationNumber;
            } else {
                //echo "No New Notification";
                return 0;
            }
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }
    public function updateNotification()
    {
        $sqlQuery = "UPDATE `notification` SET totalExperiments=? WHERE id=?";
        $statement = $this->_dbHandle->prepare($sqlQuery);
        //$statement->bindParam(1, $reqNumber);
        $statement->execute([$this->reqNumber, 1]);
    }

    public function findExpById($id)
    {
        try {
            $find_user = $this->_dbHandle->prepare("SELECT experimentID FROM `userExperiment` WHERE userID = ?");
            //$find_user = $this->_dbHandle->prepare("SELECT * FROM `userExperiment` WHERE userID = ?");
            $find_user->execute([$id]);
            $userFind = $find_user->fetchAll(PDO::FETCH_OBJ);

            return $userFind;
        }
        //catches errors caused by the PDO
        catch (PDOException $e) {
            echo "Error in PDO in find user by id function";
            die($e->getMessage());
        }
    }
    public function findUserById($id)
    {
        try {
            $find_user = $this->_dbHandle->prepare("SELECT * FROM `user` WHERE id = ?");
            //$find_user = $this->_dbHandle->prepare("SELECT * FROM `userExperiment` WHERE userID = ?");
            $find_user->execute([$id]);
            $userFind = $find_user->fetch(PDO::FETCH_ASSOC);
            $rowCount = $find_user->rowCount();
            if ($rowCount === 1) {
                return $userFind;
            } else {
                echo '<br>User Not found!<br>';
                return false;
            }
        }
        //catches errors caused by the PDO
        catch (PDOException $e) {
            echo "Error in PDO in find user by id function";
            die($e->getMessage());
        }
    }
    public function getExperiment($experimentID)
    {
        try {
            $find_Exp = $this->_dbHandle->prepare("SELECT * FROM `experiment` WHERE id = ?");
            $find_Exp->execute([$experimentID]);
            $expFind = $find_Exp->fetch(PDO::FETCH_ASSOC);
            $rowCount = $find_Exp->rowCount();
            if ($rowCount === 1) {
                return $expFind;
            } else {
                echo '<br>Experiment Not found!<br>';
                return false;
            }
        }
        //catches errors caused by the PDO
        catch (PDOException $e) {
            echo "Error in PDO in find user by id function";
            die($e->getMessage());
        }
    }
    public function userExperiment($userID, $expID)
    {
        $date = date("Y/m/d");
        $time = date("h:i a");
        $sqlQuery = "INSERT INTO userExperiment (userID, experimentID, date, time) VALUE (?, ?, ?, ?)";
        $statement = $this->_dbHandle->prepare($sqlQuery);
        $statement->bindParam(1, $userID);
        $statement->bindParam(2, $expID);
        $statement->bindParam(3, $date);
        $statement->bindParam(4, $time);
        $statement->execute();
    }
    public function searchExperiments($searchValue)
    {
        $sqlQuery = "SELECT * FROM experiment WHERE type LIKE '%$searchValue%'
                        OR name LIKE '%$searchValue%'";
        $searchResult = $this->_dbHandle->prepare($sqlQuery);
        $searchResult->execute();
        $sendResults = $searchResult->fetchAll(PDO::FETCH_ASSOC);
        if ($searchResult->rowCount() > 0) {
            return $sendResults;
        } else {
            return 1;
        }
    }
}
