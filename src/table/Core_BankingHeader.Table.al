#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77380 "Core_Banking Header"
{

    fields
    {
        field(1; "Statement No"; Code[20])
        {
        }
        field(2; "Created By"; Code[20])
        {
        }
        field(3; Bank_Code; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(4; "Date Created"; Date)
        {
        }
        field(5; "Time Created"; Time)
        {
        }
        field(6; "Total Amount"; Decimal)
        {
            CalcFormula = sum(Core_Banking_Details."Trans. Amount" where("Statement No" = field("Statement No")));
            FieldClass = FlowField;
        }
        field(7; "Number of Transactions"; Integer)
        {
            CalcFormula = count(Core_Banking_Details where("Statement No" = field("Statement No")));
            FieldClass = FlowField;
        }
        field(8; "Bank Name"; Text[150])
        {
            CalcFormula = lookup("Bank Account".Name where("No." = field(Bank_Code)));
            FieldClass = FlowField;
        }
        field(9; "Batch Is Posted"; Boolean)
        {

            trigger OnValidate()
            begin
                if Rec."Batch Is Posted" = true then begin
                    Clear(CoreBankingDetails);
                    CoreBankingDetails.Reset;
                    CoreBankingDetails.SetRange("Statement No", Rec."Statement No");
                    CoreBankingDetails.SetFilter("Trans. Amount", '>%1', 0);
                    CoreBankingDetails.SetFilter(Posted, '=%1', false);
                    if CoreBankingDetails.Find('-') then begin
                        repeat
                        begin
                            CoreBankingDetails.Validate(Posted, true);
                            CoreBankingDetails.CalcFields("Exists in Customer");
                            if CoreBankingDetails."Exists in Customer" = false then begin
                                CoreBankingDetails.Posted := false;
                            end;
                            CoreBankingDetails.Modify;
                        end;
                        until CoreBankingDetails.Next = 0;
                    end;
                end else
                    Error('Undoing Posting is Illegal');
            end;
        }
        field(10; "Posted Transactions"; Integer)
        {
            CalcFormula = count(Core_Banking_Details where("Statement No" = field("Statement No"),
                                                            Posted = filter(true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Statement No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := Today;
        "Time Created" := Time;
    end;

    var
        CoreBankingDetails: Record Core_Banking_Details;
}

