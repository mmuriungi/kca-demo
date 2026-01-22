page 50565 "HRM-Appraisal HR Emp Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                }
                field(Initials; Rec.Initials)
                {
                    Editable = false;
                }
                field("Search Name"; Rec."Search Name")
                {

                    Editable = false;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    Editable = false;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    Editable = false;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    Editable = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    Editable = false;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                }
            }
            group(EmployeeTargets)
            {
                Caption = 'Employee Targets';
                part("HRM-Appraisal Emp Targets-HR"; "HRM-Appraisal Emp Targets-HR")
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                }
            }
            group(Training)
            {
                Caption = 'Appraisee Training Needs';
                part("HRM-Appraisal Training Needs"; "HRM-Appraisal Training Needs")
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Supervisor Comments")
            {
                Caption = 'Supervisor Comments';
                Image = CalculateWIP;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "HRM-Appraisal Supervisor Com.";
                RunPageLink = "PF. No." = FIELD("No.");
            }
        }
    }

    var
        stud: Record Customer;
        PictureExists: Boolean;
        GenJnl: Record "Gen. Journal Line";
        Units: Record "HRM-Appraisal Targets";
        GenSetUp: Record "HRM-Appraisal Gen. Setup";
        CourseReg: Record "HRM-Appraisal Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "HRM-Appraisal Registration";
        CustLed2: Record "Cust. Ledger Entry";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "HRM-Appraisal Periods";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "HRM-Appraisal Jobs";
        "Settlement Type": Record "HRM-Employee Category";
        AccPayment: Boolean;
        SettlementType: Code[20];
        CustL: Record "Cust. Ledger Entry";
        Units3: Record "HRM-Appraisal Targets";
}

