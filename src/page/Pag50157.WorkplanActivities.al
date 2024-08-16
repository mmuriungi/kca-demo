page 50157 "Workplan Activities"
{
    Caption = 'Departmental Procurement Plan Activities';
    Editable = true;
    PageType = ListPart;
    SourceTable = "Workplan Activities";
        ObsoleteState=Pending;
    ObsoleteReason='Unused for this project';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Activity Code", "Activity Description";
                ShowAsTree = false;
                field("Workplan Code"; Rec."Workplan Code")
                {
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Caption = 'Activity Code';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Source Of Funds"; Rec."Source Of Funds")
                {
                }
                field("Other Source of Funds"; Rec."Other Source of Funds")
                {
                }
                field("category Sub Plan"; Rec."category Sub Plan")
                {
                    Caption = 'Category Sub-Plan';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Style = Strong;
                    StyleExpr = NoEmphasize;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Totaling; Rec.Totaling)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = NoEmphasize;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Proc. Method No."; Rec."Proc. Method No.")
                {
                }
                field("Goods Required Date"; Rec."Goods Required Date")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Cost"; Rec."Unit of Cost")
                {
                    Caption = ' Cost Per Unit';
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                }
                field("Date to Transfer"; Rec."Date to Transfer")
                {
                    Visible = false;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field("Uploaded to Procurement Workpl"; Rec."Uploaded to Procurement Workpl")
                {
                    Editable = false;
                }
                field("Converted to Budget"; Rec."Converted to Budget")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        // area(factboxes)
        // {
        //     systempart(Outlook; Outlook)
        //     {
        //     }
        //     systempart(Notes; Notes)
        //     {
        //     }
        // }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                Visible = false;
                action(IndentWorkPlan)
                {
                    Caption = 'Indent Workplan Activities';
                    Image = IndentChartOfAccounts;
                    ApplicationArea = All;
                    RunObject = Codeunit "Workplan Indent";
                }
                action("Import Procurement Plan ")
                {
                    Caption = 'Import Procurement Plan';
                    Image = Import;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //ImportProcurementPlan('');
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin


                        //IF LinesCommitted THEN
                        //ERROR('All Lines should be committed');
                        Rec.RESET;
                        Rec.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(70023, TRUE, TRUE, Rec);
                        Rec.RESET;
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group("Actions")
            {
                Caption = 'Actions';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
                    begin
                        // IF ApprovalsMgmt.CheckWActivitiesApprovalsWorkflowEnabled(Rec) THEN
                        //    ApprovalsMgmt.OnSendWActivitiesForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = true;
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
                    begin
                        //ApprovalsMgmt.OnCancelWActivitiesForApproval(Rec);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    // ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.Setfilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        //ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls;
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        Text0001: Label 'Convert to Workplan Activity [ %1-%2 ]to a Workplan Budget Entry?';
        Text0002: Label 'Workplan Budget Entry created for Workplan Activity [ %1-%2 ]';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
    // ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";

    procedure SetSelection(var GLAcc: Record "Workplan Activities")
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record "Workplan Activities";
        FirstAcc: Text[20];
        LastAcc: Text[20];
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
        GLAcc.SETCURRENTKEY("Activity Code");
        GLAccCount := GLAcc.COUNT;
        IF GLAccCount > 0 THEN BEGIN
            GLAcc.FIND('-');
            WHILE GLAccCount > 0 DO BEGIN
                GLAccCount := GLAccCount - 1;
                GLAcc.MARKEDONLY(FALSE);
                FirstAcc := GLAcc."Activity Code";
                LastAcc := FirstAcc;
                More := (GLAccCount > 0);
                WHILE More DO
                    IF GLAcc.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT GLAcc.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastAcc := GLAcc."Activity Code";
                            GLAccCount := GLAccCount - 1;
                            IF GLAccCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstAcc = LastAcc THEN
                    SelectionFilter := SelectionFilter + FirstAcc
                ELSE
                    SelectionFilter := SelectionFilter + FirstAcc + '..' + LastAcc;
                IF GLAccCount > 0 THEN BEGIN
                    GLAcc.MARKEDONLY(TRUE);
                    GLAcc.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure UpdateControls()
    begin
        /*
        IF (Type = Type::"Begin-Total") OR (Type = Type::"End-Total") THEN
        BEGIN
            FieldEditable:=FALSE;
        END ELSE
        BEGIN
            FieldEditable:=TRUE;
        END;
        */

        //For Bold and Indentation
        NoEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;

    end;

    procedure CheckRequiredFields()
    begin

        Rec.TESTFIELD("Account Type");
        Rec.TESTFIELD("Activity Description");
        Rec.TESTFIELD("Workplan Code");
        Rec.TESTFIELD("Date to Transfer", 0D);
        //if
    end;

    procedure UploadWorkplanActivities()
    var
        WorkplanEntry: Record "Workplan Entry";
        EntryNum: Integer;
    begin
        WorkplanEntry.RESET;
        WorkplanEntry.INIT;

        WorkplanEntry."Entry No." := GetNextEntryNo;

        WorkplanEntry."Workplan Code" := WorkplanEntry."Workplan Code";
        WorkplanEntry."Activity Code" := WorkplanEntry."Activity Code";
        WorkplanEntry.Date := Rec."Date to Transfer";

        //Validation will fill other variables
        WorkplanEntry.VALIDATE(WorkplanEntry.Date);

        WorkplanEntry.INSERT;
    end;

    local procedure GetNextEntryNo() EntryNumber: Integer
    var
        WorkplanEntry: Record "Workplan Entry";
        EntryNum: Integer;
    begin
        WorkplanEntry.SETCURRENTKEY("Entry No.");
        IF WorkplanEntry.FIND('+') THEN
            EXIT(WorkplanEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    // procedure ImportProcurementPlan(FileName: Text)
    // var
    //     TempBlob: Record "TempBLOB";
    //     FileManagement: Codeunit "File Management";
    //     ExportImportWorkPlan: XMLport "Workplan";
    //     InStr: InStream;
    // begin
    //     TempBlob.INIT;
    //     //IF FileManagement.BLOBImport(TempBlob, FileName) = '' THEN
    //     EXIT;
    //     TempBlob.Blob.CREATEINSTREAM(InStr);
    //     ExportImportWorkPlan.SETSOURCE(InStr);
    //     ExportImportWorkPlan.IMPORT;
    // end;
}

