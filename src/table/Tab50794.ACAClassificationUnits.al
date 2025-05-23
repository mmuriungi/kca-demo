table 50794 "ACA-Classification Units"
{
    // DrillDownPageID = 66652;
    // LookupPageID = 66652;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Credit Hourse"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "CAT Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Exam Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Pass; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Graduation Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";
        }
        field(54; Cohort; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Use In Classification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Unit Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(57; "Exists Required Units"; Boolean)
        {
            CalcFormula = Exist("ACA-Classification Course Reg." WHERE("Student Number" = FIELD("Student No."),
                                                                        Programme = FIELD(Programme),
                                                                        "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                        "Year of Study" = FIELD("Year of Study"),
                                                                        "Required Stage Units" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        //"Credit Hours"
        field(58; "Credit Hours"; Decimal)
        {

        }
        //"Allow In Graduate 222"
        field(59; "Allow In Graduate 222"; Boolean)
        {
        }
        //"School Code"
        field(60; "School Code"; Code[50])
        {
        }
        //grade remark
        field(61; "Grade Remark"; Text[150])
        {
            FieldClass  = FlowField;
            CalcFormula=Lookup("ACA-Exam Grading Source".Remarks WHERE ("Academic Year"=FIELD("Graduation Academic Year"),"Exam Catregory"=FIELD("Exam Category Flow"),"Total Score"=FIELD("Total Score Decimal"),"Results Exists Status"=FIELD("Results Exists Status")));
        }
        //Exam Category Flow
        field(62; "Exam Category Flow"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula=Lookup("ACA-Units/Subjects"."Exam Category" WHERE ("Programme Code"=FIELD(Programme),"Code"=FIELD("Unit Code")));
        }
        //Results Exists Status
        field(63; "Results Exists Status"; Option)
        {
            FieldClass = FlowField;
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
            CalcFormula=Lookup("Results Exists Status Ref"."Results Exists Status" WHERE ("CAT Marks Exists"=FIELD("CAT Exists"),"Exam Marks Exists"=FIELD("Exam Exists")));
        }
        //CAT Exists
        field(64; "CAT Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula=Exist("ACA-Classification Units" WHERE ("Student No."=FIELD("Student No."),Programme=FIELD(Programme),"Graduation Academic Year"=FIELD("Graduation Academic Year"),"Unit Code"=FIELD("Unit Code"),"CAT Score"=FILTER(<>'')));
        }
        //Exam Exists
        field(65; "Exam Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula=Exist("ACA-Classification Units" WHERE ("Student No."=FIELD("Student No."),Programme=FIELD(Programme),"Graduation Academic Year"=FIELD("Graduation Academic Year"),"Unit Code"=FIELD("Unit Code"),"Exam Score"=FILTER(<>'')));
        }
    }

    keys
    {
        key(Key1; "Student No.", "Unit Code", Programme, "Graduation Academic Year")
        {
        }
        key(Key2; "Total Score")
        {
        }
        key(Key3; "Course Cat. Presidence")
        {
        }
    }

    fieldgroups
    {
    }
}

