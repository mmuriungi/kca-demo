table 50674 "ACA-Imp. Receipts Buffer"
{

    fields
    {
        field(1; "Transaction Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Date; Date)
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
            //Editable = not Posted;
        }
        field(5; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Receipt No"; Code[20])
        {
        }
        field(7; "Student No."; Code[20])
        {
            TableRelation = Customer where("Customer Type" = const(Student));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                cust: Record Customer;
            begin

                if cust.Get(Rec."Student No.") then begin
                    Name := cust.Name;
                    if "Receipt No" = '' then begin
                        genSetup.Get();
                        genSetup.TestField("Receipt Nos.");
                        "Receipt No" := NoSeriesManagement.GetNextNo(genSetup."Receipt Nos.", 0D, True);
                    end;
                    // Rec."Batch No." := Rec."Transaction Code";
                    // Rec.Modify();
                end;

            end;
        }
        field(8; Unallocated; Boolean)
        {
        }
        field(9; "Cheque No"; Code[20])
        {
        }
        field(10; "Stud Exist"; Integer)
        {
            CalcFormula = Count(Customer WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(11; Stage; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Stage WHERE("Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(12; Name; Text[100])
        {
        }
        field(13; IDNo; Code[30])
        {
        }
        field(14; "F Name"; Text[50])
        {
        }
        field(15; "M Name"; Text[50])
        {
        }
        field(16; "L Name"; Text[50])
        {
        }
        field(17; SN; Code[20])
        {
        }
        field(18; Semester; Code[20])
        {
        }
        field(20; "Batch No."; Code[20])
        {
        }
        field(21; "User ID"; Code[30])
        {
        }
        field(22; "Ack. Receipt No."; Code[20])
        {
            Caption = 'Acknowledgement Receipt No.';
        }
        //Invalid
        field(23; Invalid; Boolean)
        {
        }


    }

    keys
    {
        key(Key1; "Transaction Code", "Student No.", Semester, "Cheque No")
        {
        }
        key(Key2; Posted, Date, "Student No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
    var
        genSetup: Record "ACA-General Set-Up";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        BatchHeader: Record "ACA-Scholarship Batches";


    trigger OnInsert()
    var
        Cust: Record Customer;
    begin
        BatchHeader.Reset();
        BatchHeader.SetRange("No.", Rec."Transaction Code");
        if BatchHeader.FindFirst() then begin
            Rec."Ack. Receipt No." := BatchHeader."Receipt No";
        end;
        Cust.Reset();
        Cust.SetRange("No.", Rec."Student No.");
        if not Cust.FindFirst() then begin
            Rec.Invalid := true;
        end;
    end;

    trigger OnModify()
    var
        Cust: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange("No.", Rec."Student No.");
        if not Cust.FindFirst() then begin
            Rec.Invalid := true;
        end else begin
            Rec.Invalid := false;
        end;
    end;
}

