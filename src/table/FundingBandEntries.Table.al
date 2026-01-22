#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78074 "Funding Band Entries"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type" = filter(Student));
            ValidateTableRelation = false;
        }
        field(2; "Student Name"; Text[150])
        {
        }
        field(3; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(4; "Admission Year"; Code[25])
        {
        }
        field(5; "KCSE Index No."; Code[20])
        {
        }
        field(6; "Band Code"; Code[20])
        {
            TableRelation = "Funding Band Categories";

            trigger OnValidate()
            begin
                //  IF NOT Bands.GET(UPPERCASE("Band Code")) THEN
                //  ERROR('Invalid Band %1 for student no %2 Name %3',"Band Code","Student No.","Student Name");
                //  sseHold Percentage":=Bands."Household Percentage";
            end;
        }
        field(7; "Band Description"; Text[150])
        {
        }
        field(8; "Programme Code"; Code[20])
        {
            TableRelation = "ACA-Programme";

            trigger OnLookup()
            var
                TotalFees: Decimal;
            begin

                //get programcost
            end;

            trigger OnValidate()
            var
                Batches: Record "Fund Band Batch";
            begin
            end;
        }
        field(9; "Programme Cost"; Decimal)
        {
        }
        field(10; "HouseHold Percentage"; Decimal)
        {
        }
        field(11; "HouseHold Fee"; Decimal)
        {
        }
        field(12; "Programm Description"; Text[150])
        {
        }
        field(13; "Last Modified By"; Code[50])
        {
        }
        field(14; "Last Modified DateTime"; DateTime)
        {
        }
        field(15; "Created By"; Code[50])
        {
        }
        field(16; "Created DateTime"; DateTime)
        {
        }
        field(17; "Batch No."; Code[25])
        {
        }
        field(18; Archived; Boolean)
        {
        }
        field(19; NationalIdNo; Code[20])
        {
        }
        field(20; "SEM1 Fee"; Decimal)
        {
        }
        field(21; "SEM2 Fee"; Decimal)
        {
        }
        field(22; POBOX; Text[200])
        {
        }
        field(23; "Entry no."; Integer)
        {
        }
        field(24; Surname; Text[100])
        {
        }
        field(25; Semester; Code[25])
        {
        }
        field(26; "Student Exists"; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Batch No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        TotalFees: Decimal;
        BatchEntry: Record "Funding Band Entries";
    begin
        // AcademicYear.RESET;
        // AcademicYear.SETRANGE(Current,TRUE);
        // IF AcademicYear.FINDFIRST THEN
        //  "Academic Year":=AcademicYear.Code;

        "Created By" := UserId;
        "Created DateTime" := CurrentDatetime;
        "Last Modified By" := UserId;
        "Last Modified DateTime" := CurrentDatetime;
        TotalFees := 0;
        CourseReg.Reset;
        CourseReg.SetRange("Student No.", "Student No.");
        CourseReg.SetRange("Academic Year", "Academic Year");
        if CourseReg.FindSet then begin
            ACAProgrammes.Get(CourseReg.Programmes);
            "Programme Code" := CourseReg.Programmes;
            //"Programm Description":=ACAProgrammes.Description;
            //  REPEAT
            //    FeeStructure.RESET;
            //    FeeStructure.SETRANGE("Stage Code",CourseReg.Stage);
            //    FeeStructure.SETRANGE("Programme Code",CourseReg.Programme);
            //    FeeStructure.SETRANGE("Settlemet Type",'NFM');
            //    IF FeeStructure.FINDFIRST THEN
            //      TotalFees+=FeeStructure."Break Down";
            //    UNTIL CourseReg.NEXT=0;
        end;
        if "HouseHold Percentage" <= 1 then
            "HouseHold Percentage" := "HouseHold Percentage" * 100;
        //"Programme Cost":=TotalFees;
        "HouseHold Fee" := ("HouseHold Percentage" / 100) * "Programme Cost";
        // FBatch.RESET;
        // FBatch.SETRANGE(Close,FALSE);
        // FBatch.SETRANGE(Archived,FALSE);
        // FBatch.SETRANGE("Academic Year","Academic Year");
        // IF FBatch.FINDLAST THEN BEGIN
        //  "Batch No.":=FBatch."Document No.";
        //  END;

        BatchEntry.Reset;
        BatchEntry.SetRange("Student No.", "Student No.");
        BatchEntry.SetRange("Admission Year", "Academic Year");
        BatchEntry.SetRange(Archived, false);
        BatchEntry.SetFilter("Batch No.", '<>%1', "Batch No.");
        if BatchEntry.FindFirst then
            Error('Band for this student already exists!');
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified DateTime" := CurrentDatetime;
    end;

    var
        Bands: Record "Funding Band Categories";
        ACAProgrammes: Record "ACA-Programme";
        FeeStructure: Record "ACA-Fee By Stage";
        CourseReg: Record "ACA-Course Registration";
        AcademicYear: Record "ACA-Academic Year";
        FBatch: Record "Fund Band Batch";
}

