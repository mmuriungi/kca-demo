page 51015 "ACA-Grant"
{
    Caption = 'ACA-Grant';
    PageType = Card;
    SourceTable = "ACA-Grants";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field("Awarding agency"; Rec."Awarding agency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Awarding agency field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Awadee; Rec.Awadee)
                {
                    Caption = 'PF No.';
                    ApplicationArea = All;
                }
                field("Awadee Name"; Rec."Awadee Name")
                {
                    Caption = 'Staff Name';
                    ApplicationArea = All;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Year field.';
                }
                field("Grant Timeframe(In Months)"; Rec."Grant Timeframe(In Months)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grant Timeframe(In Months) field.';
                }
                field("Total Amount Awarded"; Rec."Total Amount Awarded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Awarded field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Store Title"; Rec."Store Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Store Title field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Grant Type"; Rec."Grant Type")
                {
                    ApplicationArea = All;
                }
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Grants Description"; Rec."Grants Description")
                {
                    ApplicationArea = ALL;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Grant Relevant Attachments")
            {
                ApplicationArea = All;
                Caption = 'Attachments';

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
            action("Post Grant")
            {

                ApplicationArea = all;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction();
                begin
                    PostGrant.PostGrant(Rec);
                    Rec.Posted := true;
                    Rec.Modify();
                end;
            }
        }
    }
    var
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;
        PostGrant: Codeunit "Post Stud Receipt Buffer";

    // trigger OnOpenPage()
    // begin
    //     genSetUp.Get();
    //     genSetUp.TestField("Project Req No");
    //     Rec.No := noseries.GetNextNo(genSetUp."Grant Nos", TODAY, TRUE);
    //     //Rec."Batch No." := "No.";
    //     //Rec.Modify();
    // end;
}
