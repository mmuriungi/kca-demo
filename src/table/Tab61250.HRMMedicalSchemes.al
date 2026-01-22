#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61250 "HRM-Medical Schemes"
{
    DrillDownPageID = "Medical Schemes";
    LookupPageID = "Medical Schemes";

    fields
    {
        field(1; "Scheme No"; Code[10])
        {
        }
        field(2; "Medical Insurer"; Code[10])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                Insurer.Reset;
                Insurer.SetRange(Insurer."No.", "Medical Insurer");
                if Insurer.Find('-') then begin
                    "Insurer Name" := Insurer.Name;

                end;
            end;
        }
        field(3; "Scheme Name"; Text[250])
        {
        }
        field(4; "In-patient limit"; Decimal)
        {
        }
        field(5; "Out-patient limit"; Decimal)
        {
        }
        field(6; "Area Covered"; Text[30])
        {
        }
        field(7; "Dependants Included"; Boolean)
        {
        }
        field(8; Comments; Text[100])
        {
        }
        field(9; "Insurer Name"; Text[250])
        {
        }
        field(10; "Scheme Type"; Option)
        {
            OptionCaption = 'Both,Inpatient,Outpatient';
            OptionMembers = Both,Inpatient,Outpatient;
        }
        field(11; "Maximum No of Dependants"; Integer)
        {
        }
        field(12; "Start Date"; Date)
        {
        }
        field(13; "End Date"; Date)
        {
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Renewed,Closed';
            OptionMembers = Open,Renewed,Closed;
        }
        field(15; "Scheme Members"; Integer)
        {
            CalcFormula = count("HRM-Medical Scheme Members" where("Scheme No" = field("Scheme No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*IF "Scheme Members" > "Maximum No of Dependants" THEN
                BEGIN
                    ERROR('Nominated memebrs cannot exceed the required number');
                END;
                
                IF "Required Positions" <= 0 THEN
                BEGIN
                    ERROR('Required positions cannot be Less Than or Equal to Zero');
                END;
                */

            end;
        }
        field(16; Period; Code[20])
        {
            TableRelation = "HRM-Calendar".Year;
        }
        field(17; Currency; Code[10])
        {
            TableRelation = Currency;
        }
        field(18; "No. Series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Scheme No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Scheme No", "Scheme Name", "Scheme Type")
        {
        }
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Scheme No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Medical Scheme Nos");
            NoSeriesMgt.InitSeries(HRSetup."Medical Scheme Nos", xRec."No. Series", 0D, "Scheme No", "No. Series");
        end;
    end;

    var
        Insurer: Record Vendor;
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

