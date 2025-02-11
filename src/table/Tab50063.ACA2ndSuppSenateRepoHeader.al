table 66685 "ACA-2ndSuppSenate Repo. Header"
{
    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "School Code"; Code[20])
        {
        }
        field(3; "Department Code"; Code[20])
        {
        }
        field(4; "Classification Code"; Code[20])
        {
        }
        field(5; "School Classification Count"; Integer)
        {
        }
        field(6; "School Total Passed"; Integer)
        {
        }
        field(7; "School Total Failed"; Integer)
        {
        }
        field(8; "School % Passed"; Decimal)
        {
        }
        field(9; "School % Failed"; Decimal)
        {
        }
        field(10; "Calss Caption"; Code[100])
        {
        }
        field(11; "Programme Code"; Code[20])
        {
        }
        field(12; "Programme Classification Count"; Integer)
        {
        }
        field(13; "Programme Total Passed"; Integer)
        {
        }
        field(14; "Programme Total Failed"; Integer)
        {
        }
        field(15; "Programme % Passed"; Decimal)
        {
        }
        field(16; "Programme % Failed"; Decimal)
        {
        }
        field(17; "Prog. Class % Value"; Decimal)
        {
        }
        field(18; "Sch. Class % Value"; Decimal)
        {
        }
        field(19; "School Total Count"; Integer)
        {
        }
        field(20; "Prog. Total Count"; Integer)
        {
        }
        field(50005; "Status Msg6"; Text[100])
        {
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
        }
        field(50020; "Status Msg1"; Text[200])
        {
        }
        field(50021; "Status Msg2"; Text[200])
        {
        }
        field(50022; "Status Msg3"; Text[200])
        {
        }
        field(50023; "Status Msg4"; Text[200])
        {
        }
        field(50024; "Status Msg5"; Text[200])
        {
        }
        field(63021; "Summary Page Caption"; Text[200])
        {
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
        }
        field(63028; "Include Academic Year Caption"; Boolean)
        {
        }
        field(63029; "Academic Year Text"; Text[100])
        {
        }
        field(63030; "Rubric Order"; Integer)
        {
        }
        field(63031; "Year of Study"; Integer)
        {
        }
        field(63032; "School_AcadYear_Count"; Integer)
        {
        }
        field(63033; "School_AcadYear_Status_Count"; Integer)
        {
        }
        field(63051; "1st Year Grad. Comments"; Text[150])
        {
        }
        field(63052; "2nd Year Grad. Comments"; Text[150])
        {
        }
        field(63053; "3rd Year Grad. Comments"; Text[150])
        {
        }
        field(63054; "4th Year Grad. Comments"; Text[150])
        {
        }
        field(63055; "5th Year Grad. Comments"; Text[150])
        {
        }
        field(63056; "6th Year Grad. Comments"; Text[150])
        {
        }
        field(63057; "7th Year Grad. Comments"; Text[150])
        {
        }
        field(63058; "Finalists Graduation Comments"; Text[150])
        {
        }
        field(63059; "Grad. Status Msg 1"; Text[100])
        {
        }
        field(63060; "Grad. Status Msg 2"; Text[100])
        {
        }
        field(63061; "Grad. Status Msg 3"; Text[100])
        {
        }
        field(63062; "Grad. Status Msg 4"; Text[100])
        {
        }
        field(63063; "Grad. Status Msg 5"; Text[100])
        {
        }
        field(63064; "Grad. Status Msg 6"; Text[100])
        {
        }
        field(63065; "School_AcadYearTrans_Count"; Integer)
        {
        }
        field(63066; "Reporting Academic Year"; Code[20])
        {
        }
        field(63067; "SchCat_AcadYear_BarcCo"; Integer)
        {
        }
        field(63068; "SchCat_AcadYear_Status_BarcCo"; Integer)
        {
        }
        field(63069; "SchCat_AcadYearTrans_BarcCo"; Integer)
        {
        }
        field(63070; "SchCat_AcadYear_MasCo"; Integer)
        {
        }
        field(63071; "SchCat_AcadYear_Status_MasCo"; Integer)
        {
        }
        field(63072; "SchCat_AcadYearTrans_MascCo"; Integer)
        {
        }
        field(63073; "SchCat_AcadYear_DipCo"; Integer)
        {
        }
        field(63074; "SchCat_AcadYear_Status_DipCo"; Integer)
        {
        }
        field(63075; "SchCat_AcadYearTrans_DipCo"; Integer)
        {
        }
        field(63076; "SchCat_AcadYear_CertCo"; Integer)
        {
        }
        field(63077; "SchCat_AcadYear_Status_CertCo"; Integer)
        {
        }
        field(63078; "SchCat_AcadYearTrans_CertCo"; Integer)
        {
        }
        field(63079; "Category"; Option)
        {
            OptionMembers = " ";  // Add appropriate option members as needed
        }
        field(63080; "Prog_AcadYear_Count"; Integer)
        {
        }
        field(63081; "Prog_AcadYear_Status_Count"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "School Code", "Programme Code", "Classification Code")
        {
            Clustered = true;
        }
    }
}