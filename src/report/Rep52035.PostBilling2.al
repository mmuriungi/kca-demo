report 52035 "Post Billing2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.", Semester, Stage, Programmes;
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bill_StudentsCaption; Bill_StudentsCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = FIELD("Student No.");
                DataItemTableView = SORTING("No.")
                                    WHERE(Blocked = FILTER(' '));
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Billing
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    GenSetUp.GET();

                    IF Charges.GET(ChargeCode) THEN BEGIN
                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        GenJnl."Posting Date" := PDate;
                        GenJnl."Document No." := DocNo;
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        //
                        IF Cust.GET("No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "No.";
                        END;

                        GenJnl.Amount := ChargeAmount;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := Charges.Description;
                        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                        GenJnl."Bal. Account No." := Charges."G/L Account";


                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");

                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Due Date" := DueDate;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF StudentCharges."Recovery Priority" <> 0 THEN;
                        //     GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                        // ELSE
                        //     GenJnl."Recovery Priority" := 25;
                        IF GenJnl.Amount <> 0 THEN
                            GenJnl.INSERT;

                        //Post New
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                        END;

                        //Post New


                    END;


                    //BILLING
                end;
            }

            trigger OnPreDataItem()
            begin
                IF ChargeCode = '' THEN ERROR('Please select the Charge Code');
                IF ChargeAmount = 0 THEN ERROR('Please enter the Charge Amount');
                IF PDate = 0D THEN ERROR('Please enter the Charge Date');
                IF DocNo = '' THEN ERROR('Please enter the Document No');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ChargeCode; ChargeCode)
                {
                    Caption = 'Charge Code';
                    DrillDownPageID = "ACA-Charge";
                    LookupPageID = "ACA-Charge";
                    TableRelation = "ACA-Charge".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Charges.GET(ChargeCode) THEN
                            ChargeAmount := Charges.Amount;
                    end;
                }
                field(ChargeAmount; ChargeAmount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(PDate; PDate)
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
                field(DocNo; DocNo)
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";

        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";

        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        "Settlement Type": Record "ACA-Settlement Type";
        Prog: Record "ACA-Programme";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bill_StudentsCaptionLbl: Label 'Bill Students';
        // StudHost: Record "ACA-Students Hostel Rooms";
        ChargeCode: Code[20];
        ChargeAmount: Decimal;
}

