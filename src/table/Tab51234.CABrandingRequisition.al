table 51234 "CA-Branding Requisition"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "Code"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(3; "Type"; Option)
        {
            OptionMembers = "","Internal","External";
        }

        field(4; "Cost Center"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Required Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Reason; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Brand Stage"; Option)
        {
            OptionMembers = "",DD,DDCAQA,CO;
            OptionCaption = ' ,DD,DDCAQA,CO';
        }
        field(9; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Status"; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Released;
            OptionCaption = 'Open,Pending Approval,Approved,Released';
        }
        field(12; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Department; Code[100])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Department");
                IF DimVal.FIND('-') THEN
                    "Department Name" := DimVal.Name
            end;
        }
        field(14; "Department Name"; Text[250])
        {
        }
        field(15; "No. Series"; Code[30])
        {
            Description = 'Stores the number series in the database';
        }

        field(16; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGIONS'));
            trigger OnValidate()
            var
                Dimval: Record "Dimension Value";
            begin
                if Dimval.Get(Region) then begin
                    "Region Name" := Dimval.Name;
                end;
            end;
        }
        field(17; "Region Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Region)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }




    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Transport Req No");
            NoSeriesMgt.InitSeries(HRSetup."Transport Req No", xRec."No. Series", 0D, Code, "No. Series");
        END;


    end;

    var
        myInt: Integer;
        HRSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit 396;


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