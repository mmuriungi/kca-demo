page 52028 "Project Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Project Header";
    Caption = 'Contract Header Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = IsOpen;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Name';
                    Editable = IsOpen;
                }
                field("Project Date"; Rec."Project Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Contract Date';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract Category"; Rec."Contract Category")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Contract Type" = Rec."Contract Type"::Insurance then
                            isInsurance := true
                        else
                            isInsurance := false;
                    end;

                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = All;
                    Editable = isInsurance;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ApplicationArea = All;
                    Editable = IsOpen;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Extend ?"; Extend)
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field("Payment Frequency"; Rec."Payment Frequency")
                {
                    ApplicationArea = All;
                }
                field("Frequency Amount"; Rec."Frequency Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Start Date"; Rec."Payment Start Date")
                {
                    ApplicationArea = All;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = All;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                }
                //field(Recommendations; RecommendationsTxt)
                field(Recommendations; Rec.Recommendations)
                {
                    //  Editable = Status = Status::"Pending Verification";
                    Visible = ActionVerify or ActionExtend or ActionExtended;
                    Editable = ActionVerify;
                    ApplicationArea = All;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        // CalcFields(Recommendations);
                        // Recommendations.CreateInStream(InStrm);
                        // RecommendationsBigTxt.Read(InStrm);

                        // if RecommendationsTxt <> format(RecommendationsBigTxt) then begin
                        //     clear(Recommendations);
                        //     clear(RecommendationsBigTxt);
                        //     RecommendationsBigTxt.AddText(RecommendationsTxt);
                        //     Recommendations.CreateOutStream(OutStrm);
                        //     RecommendationsBigTxt.Write(OutStrm);
                        // end;

                    end;
                }
                group("Contract Extension")
                {
                    Visible = ActionExtend or ActionExtended;
                    Editable = ActionExtend;
                    field("Extend From"; Rec."Extend From")
                    {
                        ApplicationArea = All;
                    }
                    field("Extend To"; Rec."Extend To")
                    {
                        ApplicationArea = All;
                    }
                }

            }
            part("Committe Lines"; "Contract Committee")
            {
                ApplicationArea = All;
                Visible = ActionVerify or ActionExtend or ActionExtended;
                Editable = ActionVerify;
                SubPageLink = "Document No" = FIELD("No.");

            }
            part("Payment Frequency Details"; "Project Payment Details")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Header No" = field("No.");
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("No."), "Table ID" = const(Database::"Project Header");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }

            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Control53; Links)
            {
            }
            systempart(Control52; Notes)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Team)
            {
                ApplicationArea = All;
                Image = TeamSales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Team";
                RunPageLink = "Project No" = FIELD("No.");
                //  Visible = IsApproved;
            }
            action(Milestone)
            {
                ApplicationArea = All;
                Image = Task;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Tasks";
                RunPageLink = "Project No" = FIELD("No.");
                //  Visible = IsApproved or ActionExtended;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsOpen;

                trigger OnAction()
                begin
                    Rec.TestField("Project Name");
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Project Budget");
                    if Confirm('Do you want to send this contract for approval?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectWorkflowEnabled(Rec) THEN
                        //      ApprovalsMgmt.OnSendProjectForApproval(Rec);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSubmitted;

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        //    IF ApprovalsMgmt.IsProjectWorkflowEnabled(Rec) THEN
                        //    ApprovalsMgmt.OnCancelProjectRequestApproval(Rec);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                    /*IF CONFIRM('Do you want to cancel the approval request?',FALSE)=TRUE THEN
                      BEGIN
                        IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                        ApprovalsMgmt.OnCancelProjectTaskRequestApproval(Rec);
                      END;
                    
                    Approval Entries - OnAction()
                    ApprovalEntries.Setfilters(DATABASE::"Project Tasks",ApprovalEntry."Document Type"::"Project Tasks",No);
                    ApprovalEntries.RUN;
                    */

                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSubmitted;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    //ApprovalEntries.Setfilters(DATABASE::Project,ApprovalEntry."Document Type"::Project,"No.");
                    ApprovalEntries.Run;
                end;
            }
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    // trigger OnAction()
                    // var
                    // begin
                    //     //FromFile := DocumentManagement.UploadDocument("No.", CurrPage.Caption, RecordId);
                    // end;
                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        DocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(DocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        DocumentAttachment.OpenForRecReference(RecRef);
                        DocumentAttachment.RUNMODAL;
                    end;
                }
            }
            action(Suspend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved or ActionExtended;

                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Suspended;
                    end;
                end;
            }
            action(Terminate)
            {
                Image = CloseDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved or ActionExtended;

                trigger OnAction()
                var
                    Instructions: Text;
                    Choices: Text;
                    SelectedOption: Integer;
                    ReasonPage: page "General Comment";
                    TerminationReason: Text[250];
                begin
                    Commit();
                    if Action::OK = ReasonPage.RunModal() then
                        TerminationReason := ReasonPage.FnGetTerminationComment()
                    else
                        Error('Process terminated. You have to input reason');

                    if TerminationReason = '' then
                        Error('Termination Reason must have value');
                    if Confirm('Do you want to Terminate this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Terminated;
                        Rec."Terminated By" := UserId;
                        Rec."Termination Date" := Today;
                        Rec."Actual End Date" := Today;
                        Rec.Validate("Actual End Date");
                        Rec."Termination Reason" := TerminationReason;
                        Commit();
                        Rec.Modify();

                    end;
                end;
            }
            action(Resume)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSuspended;

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Open;
                    end;
                end;
            }
            action("Suggest Payment Lines")
            {
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = not Rec."Has Invoiced Lines";
                //Visible = IsApproved or ActionExtended;
                trigger OnAction()
                var
                    ObjProjectPayLines: record "Project Payment Lines";
                    LineNo: Integer;
                    LinesCount: Integer;
                    PaymentDate: Date;
                    PaymentAmount: decimal;
                    EndDate: Date;
                begin
                    Rec.TestField(Installments);
                    LinesCount := 0;
                    ObjProjectPayLines.Reset();
                    if ObjProjectPayLines.FindLast() then
                        LineNo := ObjProjectPayLines."Line No" + 1
                    else
                        LineNo := 1;
                    if not Confirm('Dou you wish to suggest payments for this contract?') then
                        exit else begin
                        ObjProjectPayLines.Reset();
                        ObjProjectPayLines.SetRange(ObjProjectPayLines."Header No", Rec."No.");
                        ObjProjectPayLines.DeleteAll();
                        repeat
                            LinesCount += 1;
                            LineNo += 1;
                            if Rec."Frequency Amount" = 0 then
                                PaymentAmount := Rec."Project Budget" / Rec.Installments
                            else
                                PaymentAmount := Rec."Frequency Amount";

                            if LinesCount = 1 then begin
                                PaymentDate := Rec."Payment Start Date";
                            end;
                            case
                                Rec."Payment Frequency" of
                                Rec."Payment Frequency"::Annually:
                                    PaymentDate := CalcDate(Format(LinesCount - 1) + 'Y', Rec."Payment Start Date");
                                Rec."Payment Frequency"::Monthly:
                                    PaymentDate := CalcDate(Format(LinesCount - 1) + 'M', Rec."Payment Start Date");
                                Rec."Payment Frequency"::Quarterly:
                                    PaymentDate := CalcDate(Format(LinesCount - 1) + 'Q', Rec."Payment Start Date");
                                Rec."Payment Frequency"::"Semi-Annually":
                                    PaymentDate := CalcDate(Format((LinesCount * 6) - 1) + 'M', Rec."Payment Start Date");
                                Rec."Payment Frequency"::Weekly:
                                    PaymentDate := CalcDate(Format(LinesCount - 1) + 'W', Rec."Payment Start Date");
                            end;


                            ObjProjectPayLines.Init();
                            ObjProjectPayLines."Line No" := LineNo;
                            ObjProjectPayLines."Header No" := Rec."No.";
                            ObjProjectPayLines."Payment Date" := PaymentDate;
                            ObjProjectPayLines."Payment Amount" := PaymentAmount;
                            ObjProjectPayLines.Insert(true);
                        until LinesCount = Rec.Installments;
                        Message('Lines Created');
                    end;
                end;
            }
            action("Contract Form")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProjectHeader: record "Project Header";
                begin
                    Commit();
                    ProjectHeader.Reset();
                    ;
                    ProjectHeader.SetRange(ProjectHeader."No.", Rec."No.");
                    if ProjectHeader.FindFirst() then begin
                        Report.Run(Report::"Contract Form", true, false, ProjectHeader);
                    end;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = "Status" = "Status"::"Verified";
                //  Visible = Status = Status::Approved;
                Visible = IsApproved or ActionExtended;

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec.Validate("Actual End Date", Today);
                    end;
                end;
            }
            action("Project Team")
            {
                Image = TeamSales;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                // Visible = IsFinished;

                trigger OnAction()
                begin
                    Commit();
                    Project.Reset;
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst then
                        REPORT.Run(report::"Project Team", true, false, Project)
                end;
            }
            action("Contract Milestones")
            {
                Image = Task;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                //   Visible = IsFinished;

                trigger OnAction()
                begin
                    Commit();
                    Project.Reset;
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst then
                        REPORT.Run(report::"Project Tasks", true, false, Project)
                end;
            }
            action(Verify)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //  Visible = "Status" = "Status"::"Pending Verification";
                Visible = false;
                Caption = ' Send For Verification';

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this contract for Verification?', false) = true then begin
                        Rec.Status := Rec.Status::Verified;
                    end;
                end;
            }
            action(Extend)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Verified;

                trigger OnAction()
                var
                    TbProjectHeader: Record "Project Header";
                begin
                    if Confirm('Do you want to Extend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Extended;
                        //   if TbProjectHeader.Modify(true) then begin
                        TbProjectHeader.Reset();
                        TbProjectHeader.SetRange("No.", Rec."No.");
                        if TbProjectHeader.FindSet() then begin
                            TbProjectHeader."Actual Start Date" := TbProjectHeader."Extend From";
                            TbProjectHeader."Actual End Date" := TbProjectHeader."Extend To";
                            TbProjectHeader.Modify(true);
                        end;
                        //  end;
                    end;
                end;
            }
            action("Send for Verification")
            {
                Image = SendApprovalRequest;
                Caption = 'Send to the committee';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this Contract to the committee?', false) = true then begin
                        Rec.Status := Rec.Status::"Pending Verification";
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageControls;
        projectDetails.Reset();
        projectDetails.SetRange(projectDetails."Header No", Rec."No.");
        projectDetails.setrange(projectDetails."Invoice Generated", true);
        if projectDetails.Find('-') then begin
            Rec."Has Invoiced Lines" := true;
            Rec.Modify();
        end else begin
            Rec."Has Invoiced Lines" := false;
            Rec.Modify();
        end;
    end;

    trigger OnOpenPage()
    begin
        SetPageControls;
    end;

    trigger OnClosePage()
    begin
        if Rec.Status = Rec.Status::Open then
            MESSAGE('Kindly Send this document for Approval if completely filled!');
    end;

    var
        IsOpen: Boolean;
        Extend: Boolean;
        IsSubmitted: Boolean;
        IsApproved: Boolean;
        isInsurance: Boolean;
        IsSuspended: Boolean;
        IsFinished: Boolean;
        ProjectTeam: Record "Project Team";
        ProjectTasks: Record "Project Tasks";
        Project: Record "Project Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecommendationsTxt: Text;
        RecommendationsBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        FromFile: Text;
        ActionVerify: Boolean;
        ActionExtend: Boolean;
        ActionExtended: Boolean;

        TaskError: Label 'There must be at least one milestone for contract %1 before  you send for verification.';
        TaskStatusError: Label 'Milestone %1 must be finished or suspended before sending for verification.';

        projectDetails: Record "Project Payment Lines";

    local procedure SetPageControls()
    begin
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::"Pending Approval":
                IsSubmitted := true;
            Rec.Status::Approved:
                IsApproved := true;
            Rec.Status::Finished:
                IsFinished := true;
            Rec.Status::Suspended:
                IsSuspended := true;


        end;
        if Rec.status = Rec.status::"Pending Verification" then
            ActionVerify := true
        else
            ActionVerify := false;
        if Rec.status = Rec.status::Verified then
            ActionExtend := true
        else
            ActionExtend := false;
        if Rec.status = Rec.status::Extended then
            ActionExtended := true
        else
            ActionExtended := false;


    end;
}

