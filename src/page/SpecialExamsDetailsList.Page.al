#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 78002 "Special Exams Details List"
{
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Aca-Special Exams Details";
    SourceTableView = where(Category = filter(Special));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit Programme';
                    Editable = true;
                }
                field("Special Exam Reason"; Rec."Special Exam Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Exam Marks"; Rec."Exam Marks")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Marks"; Rec."Total Marks")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cost Per Exam"; Rec."Cost Per Exam")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Academic Year"; Rec."Current Academic Year")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit Academic Year';
                    Editable = true;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit Semester';
                    Editable = true;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit Stage';
                    Editable = true;
                }
                field(Occurances; Rec.Occurances)
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnSendDocForApproval(variant);
                end;
            }
            action("Approvals&")
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Approvalentries: Page "Approval Entries";
                    ObjApprov: Record "Approval Entry";
                begin
                    //DocumentType:=DocumentType::"Payment Voucher";
                    ObjApprov.Reset;
                    ObjApprov.SetRange("Table ID", Database::"Aca-Special Exams Details");
                    //ObjApprov.SETRANGE("Document No.",Rec."Student No.");
                    if ObjApprov.FindSet then begin
                        Clear(Approvalentries);
                        Approvalentries.SetTableview(ObjApprov);
                        Approvalentries.Run();
                    end;
                end;
            }
        }
    }

    var
        ApprovalMgmt: Codeunit "Approval Workflows V1";
        WorkflowManagement: Codeunit "Workflow Management";
        WrkflowEvent: Codeunit "Workflow Event Handling";
}

