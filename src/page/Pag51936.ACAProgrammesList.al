/// <summary>
/// Page ACA-Programmes List (ID 68757).
/// </summary>
page 51936 "ACA-Programmes List"
{
    CardPageID = "ACA-Programmes";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Programme";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Total Income"; Rec."Total Income")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Student Registered"; Rec."Student Registered")
                {
                    ApplicationArea = All;
                }
                field("Male Count"; Rec."Male Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Female Count"; Rec."Female Count")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Not Classified"; Rec."Not Classified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Programme)
            {
                Caption = 'Programme';
                action(Semesters)
                {
                    Caption = 'Semesters';
                    Ellipsis = true;
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "ACA-Programme Semesters";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action(update)
                {

                    Ellipsis = true;
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        deletestudUnits();
                    end;

                }
                action(recon)
                {
                    Caption = 'Stages';
                    Ellipsis = true;
                    Image = LedgerBook;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = Page BufferPage;
                    ApplicationArea = All;
                }
                action(Stages)
                {
                    Caption = 'Stages';
                    Ellipsis = true;
                    Image = LedgerBook;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Programme Stages";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Defined Graduation Units")
                {
                    Caption = 'Defined Graduation Units';
                    Ellipsis = false;
                    Image = MakeDiskette;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    RunObject = Page "ACA-Prog. Defined Units/YoS";
                    RunPageLink = Programmes = FIELD(Code);
                    ApplicationArea = All;
                }
                action("New Student Charges")
                {
                    Caption = 'New Student Charges';
                    Image = CheckJournal;
                    Promoted = true;
                    RunObject = Page "ACA-New Student Charges";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Prog. Graduation Groups")
                {
                    Caption = 'Prog. Graduation Groups';
                    Ellipsis = true;
                    Image = VoucherGroup;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "ACA-Programme Grad. Groups";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }

                action("Release Allocation")
                {
                    Caption = 'Release Allocation';
                    Image = Worksheet;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TimeTable.RESET;
                        TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        IF TimeTable.FIND('-') THEN BEGIN
                            REPEAT
                                TimeTable.Released := TRUE;
                                TimeTable.MODIFY;
                            UNTIL TimeTable.NEXT = 0;

                        END;

                        MESSAGE('Release completed successfully.');
                    end;
                }
                action("Undo Release Allocation")
                {
                    Caption = 'Undo Release Allocation';
                    Image = Worksheet;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TimeTable.RESET;
                        TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        IF TimeTable.FIND('-') THEN BEGIN
                            REPEAT
                                TimeTable.Released := FALSE;
                                TimeTable.MODIFY;
                            UNTIL TimeTable.NEXT = 0;

                        END;

                        MESSAGE('Process completed successfully.');
                    end;
                }

                action("Entry Subjects")
                {
                    Caption = 'Entry Subjects';
                    Image = Entries;
                    Promoted = true;
                    RunObject = Page "ACA-Programme Entry Subjects";
                    RunPageLink = Programme = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Admission Req. Narration")
                {
                    Image = Worksheet;
                    RunObject = Page "ACA-Admission Narration";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                separator(____)
                {
                }
                action("Programme Options")
                {
                    Caption = 'Programme Options';
                    Image = Worksheet;
                    RunObject = Page "ACA-Programme Option";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    Image = InventoryJournal;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        prog.RESET;
                        prog.SETRANGE(prog.Programme, Rec.Code);
                        IF prog.FIND('-') THEN BEGIN
                            REPORT.RUN(Report::"Fee Structure Summary Report", TRUE, TRUE, prog);
                        END;
                    end;
                }
                action("Copy Fee Structure")
                {
                    Caption = 'Copy Fee Structure';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Copy Fee Structure?', FALSE) = FALSE THEN ERROR('Cancelled by user!');
                        PAGE.RUN(Page::"ACA-Copy Fee Structure", Rec);
                    end;
                }
            }
        }
    }

    var
        TimeTable: Record "ACA-Time Table";
        prog: Record "ACA-Time Table";
        reg: Record "ACA-Course Registration";
        studUnits: Record "ACA-Student Units";
        cust: Record Customer;

    procedure deletestudUnits()
    begin
        reg.Reset();
        reg.SetRange(Semester, 'SEP-DEC23');
        if reg.Find('-') then begin
            repeat
                cust.Reset();
                cust.SetRange("No.", reg."Student No.");
                if cust.Find('-') then begin
                    cust.CalcFields(Balance);
                    if cust.Balance > 0 then begin
                        studUnits.Reset();
                        studUnits.SetRange(Semester, 'SEP-DEC23');
                        studUnits.SetRange("Student No.", cust."No.");
                        if studUnits.Find('-') then begin
                            studUnits.DeleteAll();
                        end;
                    end;

                end;
            until reg.Next() = 0;
        end;
    end;
}

