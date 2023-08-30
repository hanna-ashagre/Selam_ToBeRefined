import static javax.swing.JOptionPane.*;
import java.time.LocalDate;

String nameofcenter= "Bishoftu General Hospital";
String choose; 
String phoneNumber;
String name;
String address;
String age;
String sex;

String dateStamp;
String newqueue;
String mainTablePath;
String queuePath;

Table mainTable, queueTable;

File queue;

String getFormattedDate () {
  return year () +"-"+ (month () < 10? "0" + month () : month()) +"-"+( day () <10?"0"+ day():day());
}

Table checkAndLoadTable (String path) {
  File file = new File (path);
  if (file.exists ()) {
    return loadTable (path, "header");
  } else {
    return new Table ();
  }
}

boolean isNewPatient (String phoneNumber) {
  int rIndex = mainTable.findRowIndex (phoneNumber, 0);
  if (rIndex == -1){
    return 
    //comment
}

void setup() {
  dateStamp = getFormattedDate ();

  mainTablePath="Patients.csv";
  queuePath = "Sequence_"+dateStamp+".csv";

  mainTable = checkAndLoadTable (mainTablePath);
  queueTable = checkAndLoadTable (queuePath);

  choose=showInputDialog("Well Come To "+nameofcenter+" \n 1. card = 50 birr\n2. detail");
  if (choose.equals ("1") || choose.equals ("2")) {
    if (int(choose)==1) {
      phoneNumber = showInputDialog("Please enter your phone number \n For Ethiotelecom start from 9\n For Safaricom start from 7 ");      
      boolean isNew = ;


      if (isNew == false) { 
        String datepay=mainTable.getRow(rIndex).getString("date");
        int diff = diffBetween ( datepay, dateStamp );

        println ( "the day difference is:", diff);
        if (diff<=5) {
          name =mainTable.getRow(rIndex).getString("Name");
          age =mainTable.getRow(rIndex).getString("Age");
          address =mainTable.getRow(rIndex).getString("Address");
          sex =mainTable.getRow(rIndex).getString("Sex");
          phoneNumber =mainTable.getRow(rIndex).getString("Phone number");
          mainTable.getRow(rIndex).setString ("date", dateStamp);
          String date =dateStamp;
          saveTable (mainTable, mainTablePath);

          save_patient_info(queueTable, phoneNumber, name, address, age, sex, date, queuePath);
          println(queueTable.getString(0, 0));
          int  order=queueTable.findRowIndex(name, 1);
          showMessageDialog(null, "Payment Is Success.there are "+order+"  registrants before you");
        } else {

          showMessageDialog(null, "to register please pay 50ETB by telebirr.Then send the transaction code ");

          String validt="ABC";
          String tranc=showInputDialog("Please Enter Transaction code");
          tranc=tranc.toUpperCase();
          if (tranc.equals(validt)) {

            //  println (yearof);

            name =mainTable.getRow(rIndex).getString("Name");
            age =mainTable.getRow(rIndex).getString("Age");
            address =mainTable.getRow(rIndex).getString("Address");
            sex =mainTable.getRow(rIndex).getString("Sex");
            phoneNumber =mainTable.getRow(rIndex).getString("Phone number");
            mainTable.getRow(rIndex).setString ("date", dateStamp);
            String date =dateStamp;
            saveTable (mainTable, mainTablePath);

            save_patient_info(queueTable, phoneNumber, name, address, age, sex, date, queuePath);
            println(queueTable.getString(0, 0));
            int  order=queueTable.findRowIndex(name, 1);
            showMessageDialog(null, "Payment Is Success.there are "+order+"  registrants before you");
          } else {
            showMessageDialog(null, "error tansaction code");
          }
        }
      } else {
        // New patients (isNew true)
        // phoneNumber =showInputDialog("please enter your phoneNumber \n For Ethiotelecom start from 9\n For Safaricom start from 7 "); 
        name =showInputDialog("Please enter your full name ");
        address =showInputDialog("Please enter your address ");
        age=showInputDialog("Please enter your age ");
        sex=showInputDialog("Please enter your sex(F/M) ");
        name=name.toUpperCase();
        address=address.toUpperCase();
        sex=sex.toUpperCase();
        // phonenumber = phonenumber.substring(1,phonenumber.length());
        showMessageDialog(null, "please pay 50 birr for service in telebirr.then send transaction code!");

        String transaction=showInputDialog("please enter your transaction code");
        String tranv="SEL";
        String date=dateStamp;
        if (transaction.equals(tranv)) {
          save_patient_info( mainTable, phoneNumber, name, address, age, sex, date, mainTablePath); 
          save_patient_info (queueTable, phoneNumber, name, address, age, sex, date, queuePath);

          // println(sequenceTable.getString(1, 0));
          int sorder=queueTable.findRowIndex(name, 1);
          println (sorder);
          showMessageDialog(null, "Payment Is Success.there are "+sorder+"  registrants before you");
        } else
        {
          showMessageDialog(null, "error tansaction code");
        }
      }
    } else if (int(choose)==2) {
      String  detail=showInputDialog("1. address\n2. service");

      if (int(detail)==1) {

        showMessageDialog(null, "our address // bishoftu, evangelical");
      } else if (int(detail)==2) {
        showMessageDialog(null, "Yemnsetachew Agelglotoch\n1. lewust dewe\n2.le cheguara\n3. kanget belay hikmina\n4. le tirf anget ");
      } else {
        showMessageDialog(null, "error number");
      }   // for address and service input
    } else {
      showMessageDialog(null, "please enter correct number");
    }
  }
} // void setup

void save_patient_info(Table table, String  phonenumber, String name, String address, String age, String sex, String date, String path ) {
  if (path.equals(mainTablePath)||(queue.exists())&&path.equals(queuePath)) {
    //println ("Here 1", path);
    TableRow new_info = table.addRow();
    new_info.setString("Phone number", phonenumber);
    new_info.setString("Name", name);
    new_info.setString("Address", address);
    new_info.setString("Age", age);
    new_info.setString("Sex", sex);
    new_info.setString("date", date);
    println("file saved!");
    saveTable(table, path );
  } else {
    println (dateStamp);
    //println ("Here 2", path);
    //sequenceTable=new Table();
    TableRow new_info=table.addRow();
    new_info.setString("Phone number", phonenumber);
    new_info.setString("Name", name);
    new_info.setString("Address", address);
    new_info.setString("Age", age);
    new_info.setString("Sex", sex);
    new_info.setString("date", date);
    saveTable(table, path );
  }
}
int diffBetween (String prev, String today) {
  println(prev);
  println(today);

  LocalDate prevDate = LocalDate.parse (prev);
  LocalDate currDate = LocalDate.parse (today);

  int counter = 0;

  while (!prevDate.isAfter (currDate)) {
    prevDate = prevDate.plusDays (1);

    counter ++;
  }

  counter --;

  return counter;
}
