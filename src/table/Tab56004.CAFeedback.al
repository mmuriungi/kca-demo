table 56004 "CA-Feedback"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Code; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Region; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, Region);
                IF DimVal.FIND('-') THEN
                    "Region Name" := DimVal.Name
            end;

        }
        field(4; "Region Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Region)));
            FieldClass = FlowField;
        }
        field(5; "Cost Center"; Text[100])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Cost Center");
                IF DimVal.FIND('-') THEN
                    "Cost Center Name" := DimVal.Name
            end;

        }
        field(6; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Complaint"; Code[30])
        {
            TableRelation = "CA-Complaints".Code; //WHERE(Code= CONST(Complaint));

            trigger OnValidate()
            var
                CAComplaint: Record "CA-Complaints";
            begin
                CAComplaint.RESET;
                CAComplaint.SETRANGE(CAComplaint.Code, Complaint);
                IF CAComplaint.FIND('-') THEN
                    "Complaint description" := CAComplaint."Complaint Description";
            end;
        }
        field(10; "Complaint description"; Text[200])
        {

        }

        field(11; "Cost Center Name"; Text[250])
        {
        }
        field(12; "FeedBack Status"; Option)
        {
            OptionMembers = "","Positive","Negative";
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "Code" = '' THEN BEGIN
            NoSeriesMgt.InitSeries('CAFEEDBK', xRec."No Series", 0D, "Code", "No Series");
        END;
        "User Id" := USERID;
        "Date Created" := CURRENTDATETIME;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}