page 51986 "CA-Feedback Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-Feedback";
    Editable = true;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;

                }
                field("Region Name"; Rec."Region Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cost Center Code"; Rec."Cost Center")
                {
                    ApplicationArea = All;

                }
                field("Cost Center Name"; Rec."Cost Center Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Complaint"; Rec.Complaint)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Complaint Description"; Rec."Complaint description")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FeedBack Status"; Rec."FeedBack Status")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = true;
                Action("Upload Attachment")
                {
                    Caption = 'Upload Attachment';
                    ApplicationArea = All;
                    PromotedIsBig = true;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Document Attachments";
                    RunPageLink = "Document No" = FIELD(Code);
                }
                action(Response)
                {
                    Caption = 'Response';
                    ApplicationArea = All;
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = List;
                    RunObject = Page "Feedback Response";
                    RunPageLink = Code = FIELD(Code);
                }
            }

        }

    }
    var
        myInt: Integer;
}