table 51329 "Audit Period"
{
    fields
    {

        field(1; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Period Start"; Date)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(4; "Period End"; Date)
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(5; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ClosingDates = true;
            FieldClass = FlowFilter;
        }
        field(8; "Audit Filter"; Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = Audit;
        }
        field(9; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Audit,Workplan';
            OptionMembers = " ",Audit,Workplan;
        }
        field(10; Closed; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(11; "Respose Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Audit Manager"; Code[90])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Employee where(Auditor = filter(true));
            trigger OnValidate()
            var
                ObjEmp: Record Employee;
            begin
                ObjEmp.Reset();
                ObjEmp.SetRange(ObjEmp."No.", "Audit Manager");
                if ObjEmp.FindFirst() then begin
                    Name := ObjEmp."Search Name";
                    Email := ObjEmp."E-Mail";
                end;
            end;
        }
        field(13; Name; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Email; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Period, Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

