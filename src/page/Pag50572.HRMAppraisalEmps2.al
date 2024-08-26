page 50572 "HRM-Appraisal Emps 2"
{
    Caption = 'All Students List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {

                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Staff';
                action("Tremester registration")
                {
                    Caption = ' Registration';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Registration";
                    RunPageLink = "PF No." = FIELD("No.");
                }
                action("Student Units")
                {
                    Caption = 'Targets';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Appraisee Target";
                    RunPageLink = "PF. No." = FIELD("No.");
                }
                action("Registration Details")
                {
                    Caption = 'Registration Details';
                    Image = Info;
                    RunObject = Page "HRM-Appraisal Registration 2";
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    var
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
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
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
        stud: Record Customer;

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

