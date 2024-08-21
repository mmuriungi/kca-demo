#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77391 "Admission Approval Entries"
{

    fields
    {
        field(1; ser; Integer)
        {
        }
        field(2; Index; Code[20])
        {
        }
        field(3; Admin; Code[20])
        {
        }
        field(4; Prog; Code[20])
        {
        }
        field(5; Names; Text[100])
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(7; Phone; Code[20])
        {
        }
        field(8; "Alt. Phone"; Code[20])
        {
        }
        field(9; Box; Code[50])
        {
        }
        field(10; Codes; Code[20])
        {
        }
        field(11; Town; Code[40])
        {
        }
        field(12; Email; Text[100])
        {
        }
        field(13; "Slt Mail"; Text[100])
        {
        }
        field(14; Processed; Boolean)
        {
        }
        field(15; County; Code[50])
        {
            TableRelation = "ACA-Academics Central Setups";
        }
        field(16; "Date of Birth"; Date)
        {
        }
        field(17; "ID Number/BirthCert"; Text[50])
        {
        }
        field(19; "Intake Code"; Code[10])
        {
        }
        field(22; Updated; Boolean)
        {
        }
        field(23; "NIIMS No"; Text[30])
        {
        }
        field(24; "Physical Impairments"; Boolean)
        {
        }
        field(25; "Physical impairments Details"; Text[150])
        {
        }
        field(26; "NHIF No"; Text[30])
        {
        }
        field(27; Religion; Code[10])
        {
            TableRelation = "ACA-Religions".Religion;
        }
        field(28; Nationality; Code[10])
        {
        }
        field(29; "Marital Status"; Option)
        {
            OptionCaption = 'Single,Married,Divorced,Widowed';
            OptionMembers = Single,Married,Divorced,Widowed;
        }
        field(30; "Name of Spouse"; Text[100])
        {
        }
        field(31; "Occupation of Spouse"; Text[100])
        {
        }
        field(32; "Spouse Phone No"; Code[30])
        {
        }
        field(33; "Number of Children"; Text[30])
        {
        }
        field(34; "Full Name of Father"; Text[100])
        {
        }
        field(35; "Father Status"; Option)
        {
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(36; "Father Occupation"; Text[100])
        {
        }
        field(37; "Father Date of Birth"; Date)
        {
        }
        field(38; "Name of Mother"; Text[100])
        {
        }
        field(39; "Mother Status"; Option)
        {
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(40; "Mother Occupation"; Text[100])
        {
        }
        field(41; "Mother Date of Birth"; Date)
        {
        }
        field(42; "Number of brothers and sisters"; Code[20])
        {
        }
        field(43; "Place of Birth"; Text[100])
        {
        }
        field(44; "Permanent Residence"; Text[30])
        {
        }
        field(45; "Nearest Town"; Text[100])
        {
        }
        field(46; Location; Text[100])
        {
        }
        field(47; "Name of Chief"; Text[100])
        {
        }
        field(48; "Sub-County"; Text[100])
        {
        }
        field(49; Constituency; Text[100])
        {
        }
        field(50; "Nearest Police Station"; Text[100])
        {
        }
        field(51; "Emergency Name1"; Text[100])
        {
        }
        field(52; "Emergency Relationship1"; Text[100])
        {
        }
        field(53; "Emergency P.O. Box1"; Text[50])
        {
        }
        field(54; "Emergency Phone No1"; Code[30])
        {
        }
        field(55; "Emergency Email1"; Text[50])
        {
        }
        field(56; "Emergency Name2"; Text[50])
        {
        }
        field(57; "Emergency Relationship2"; Text[50])
        {
        }
        field(58; "Emergency P.O. Box2"; Text[50])
        {
        }
        field(59; "Emergency Phone No2"; Code[30])
        {
        }
        field(60; "Emergency Email2"; Text[50])
        {
        }
        field(61; "OLevel School"; Text[100])
        {
        }
        field(63; "OLevel Year Completed"; Code[20])
        {
        }
        field(64; "Primary School"; Text[50])
        {
        }
        field(65; "Primary Index no"; Code[30])
        {
        }
        field(66; "Primary Year Completed"; Code[20])
        {
        }
        field(67; "K.C.P.E. Results"; Text[10])
        {
        }
        field(68; "Any Other Institution Attended"; Text[50])
        {
        }
        field(69; Results; Boolean)
        {
        }
        field(70; Selected; Boolean)
        {
        }
        field(71; "Medical Doc Verified"; Boolean)
        {
        }
        field(72; "Result Slip Verified"; Boolean)
        {
        }
        field(73; "Bank Slip Verified"; Boolean)
        {
        }
        field(74; "Id Verified"; Boolean)
        {
        }
        field(75; "Bank Slip Number"; Boolean)
        {
        }
        field(76; "Medical Doc Uploaded"; Boolean)
        {
        }
        field(77; "Result Slip Uploaded"; Boolean)
        {
        }
        field(78; "Bank Slip Uploaded"; Boolean)
        {
        }
        field(79; "Id Uploaded"; Boolean)
        {
        }
        field(80; "Medical Url"; Text[50])
        {
        }
        field(81; "Result Slip Url"; Text[50])
        {
        }
        field(82; "Bank Slip Url"; Text[50])
        {
        }
        field(83; "Id Url"; Text[50])
        {
        }
        field(84; "Email Notification Send"; Boolean)
        {
        }
        field(85; "SMS Notification Send"; Boolean)
        {
        }
        field(86; Include_Hostel; Boolean)
        {
        }
        field(87; "Academic Year"; Code[20])
        {
        }
        field(88; OTP; Code[10])
        {
        }
        field(89; "OTP Last Send Date"; Date)
        {
        }
        field(90; "OTP Last Send Time"; Time)
        {
        }
        field(91; "OTP Expiry Date"; Date)
        {
        }
        field(92; "OTP Expiry Time"; Time)
        {
        }
        field(93; Accomodation; Option)
        {
            OptionCaption = ' ,Redisent,Non-resident';
            OptionMembers = " ",Redisent,"Non-resident";
        }
        field(94; "Non-Resident Owner"; Text[50])
        {
        }
        field(95; "Non-Resident Address"; Text[50])
        {
        }
        field(96; "Residential Owner Phone"; Text[20])
        {
        }
        field(97; "Asigned Room"; Code[20])
        {
            CalcFormula = lookup("ACA-Admission Accom. Rooms"."Room Code" where("Student No." = field(Admin)));
            FieldClass = FlowField;
        }
        field(98; "Assigned Space"; Code[20])
        {
            CalcFormula = lookup("ACA-Admission Accom. Rooms"."Space Code" where("Student No." = field(Admin)));
            FieldClass = FlowField;
        }
        field(99; "Asigned Block"; Code[20])
        {
            CalcFormula = lookup("ACA-Admission Accom. Rooms"."Block Code" where("Student No." = field(Admin)));
            FieldClass = FlowField;
        }
        field(100; "Funding Category"; Code[20])
        {
            TableRelation = "Student Funding Categories"."Category Code";
        }
        field(101; "Funding %"; Decimal)
        {
            CalcFormula = sum("Category Funding Sources"."Funding %" where("Category Code" = field("Funding Category")));
            FieldClass = FlowField;
        }
        field(102; Billable_Amount; Decimal)
        {
            CalcFormula = sum("Admissions Billable Items"."Charge Amount" where(Index = field(Index),
                                                                                 Admin = field(Admin)));
            FieldClass = FlowField;
        }
        field(103; Confirmed; Boolean)
        {
        }
        field(104; "Last Booked Date/Time"; DateTime)
        {
        }
        field(106; "Booking Expiry Date/Time"; DateTime)
        {
        }
        field(107; Approver_Id; Code[20])
        {
        }
        field(108; "Approved The Document"; Boolean)
        {
        }
        field(109; "Approved Date/Time"; DateTime)
        {
        }
        field(110; "Approval Status"; Option)
        {
            OptionCaption = 'Created,Open,Approved,Rejected,Reject Reason';
            OptionMembers = Created,Open,Approved,Rejected,"Reject Reason";
        }
        field(111; "Document Code"; Code[50])
        {
        }
        field(112; "Approval Sequence"; Integer)
        {
        }
        field(113; "Attachment Exists"; Boolean)
        {
            CalcFormula = exist("ACA-New Stud. Documents" where("Academic Year" = field("Academic Year"),
                                                                 "Index Number" = field(Index),
                                                                 "Document Code" = field("Document Code"),
                                                                 "Document Uploaded" = filter(true)));
            FieldClass = FlowField;
        }
        field(114; "Approval Comments"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; ser, "Academic Year", Approver_Id, "Document Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ACAAcademicYear: Record "ACA-Academic Year";
}

