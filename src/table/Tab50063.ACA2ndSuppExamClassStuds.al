table 66684 "ACA-2ndSuppExam Class. Studs"
{
    fields
    {
        field(1; "Student Number"; Code[20])
        {
        }
        field(2; "Student Name"; Text[150])
        {
        }
        field(3; "Programme"; Code[20])
        {
        }
        field(4; "Department"; Code[20])
        {
        }
        field(5; "School Code"; Code[20])
        {
        }
        field(6; "Department Name"; Text[150])
        {
        }
        field(7; "School Name"; Text[150])
        {
        }
        field(8; "Final Stage"; Code[20])
        {
        }
        field(9; "Final Year of Study"; Integer)
        {
        }
        field(10; "Academic Year"; Code[20])
        {
        }
        field(11; "Graduating"; Boolean)
        {
        }
        field(12; "Classification"; Code[50])
        {
        }
        field(13; "Total Courses"; Integer)
        {
        }
        field(14; "Total Units"; Decimal)
        {
        }
        field(15; "Admission Date"; Date)
        {
        }
        field(16; "Admission Academic Year"; Code[20])
        {
        }
        field(17; "Final Academic Year"; Code[21])
        {
        }
        field(18; "Total Marks"; Decimal)
        {
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
        }
        field(20; "Normal Average"; Decimal)
        {
        }
        field(21; "Weighted Average"; Decimal)
        {
        }
        field(22; "Total Failed Courses"; Integer)
        {
        }
        field(23; "Total Failed Units"; Decimal)
        {
        }
        field(24; "Failed Courses"; Integer)
        {
        }
        field(25; "Failed Units"; Decimal)
        {
        }
        field(26; "Failed Cores"; Integer)
        {
        }
        field(27; "Failed Required"; Integer)
        {
        }
        field(28; "Failed Electives"; Integer)
        {
        }
        field(29; "Total Cores Done"; Integer)
        {
        }
        field(30; "Total Cores Passed"; Integer)
        {
        }
        field(31; "Total Required Done"; Integer)
        {
        }
        field(32; "Total Electives Done"; Integer)
        {
        }
        field(33; "Tota Electives Passed"; Integer)
        {
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
        }
        field(35; "Classified Electives Units"; Decimal)
        {
        }
        field(36; "Total Classified C. Count"; Integer)
        {
        }
        field(37; "Total Classified Units"; Decimal)
        {
        }
        field(38; "Classified Total Marks"; Decimal)
        {
        }
        field(39; "Classified W. Total"; Decimal)
        {
        }
        field(40; "Classified Average"; Decimal)
        {
        }
        field(41; "Classified W. Average"; Decimal)
        {
        }
        field(42; "Final Classification"; Code[50])
        {
        }
        field(43; "Final Classification Pass"; Boolean)
        {
        }
        field(44; "Final Classification Order"; Integer)
        {
        }
        field(45; "Graduation Grade"; Code[20])
        {
        }
        field(46; "Final Classification Grade"; Code[20])
        {
        }
        field(48; "Total Required Passed"; Integer)
        {
        }
        field(49; "Year of Study"; Integer)
        {
        }
        field(50; "Required Stage Units"; Decimal)
        {
        }
        field(51; "Attained Stage Units"; Integer)
        {
        }
        field(52; "Units Deficit"; Decimal)
        {
        }
        field(54; "Cohort"; Code[20])
        {
        }
        field(55; "Status Students Count"; Integer)
        {
        }
        field(56; "Programme Option"; Code[20])
        {
        }
        field(57; "Results Exists Status"; Option)
        {
            OptionMembers = " ";  // Add appropriate option members as needed
        }
        field(58; "No. of Resits"; Integer)
        {
        }
        field(59; "No. of Repeats"; Integer)
        {
        }
        field(60; "% Total Failed Courses"; Integer)
        {
        }
        field(61; "% Total Failed Units"; Decimal)
        {
        }
        field(62; "% Failed Courses"; Integer)
        {
        }
        field(63; "% Failed Units"; Decimal)
        {
        }
        field(64; "% Failed Cores"; Integer)
        {
        }
        field(65; "% Failed Required"; Integer)
        {
        }
        field(66; "% Failed Electives"; Integer)
        {
        }
        field(67; "Finalist"; Boolean)
        {
        }
        field(68; "Reporting Academic Year"; Code[20])
        {
        }
        field(109; "Supp/Special Exists"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Student Number", "Academic Year", "Programme")
        {
            Clustered = true;
        }
    }
}