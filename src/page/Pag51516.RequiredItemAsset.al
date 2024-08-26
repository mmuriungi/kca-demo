page 51516 "Required Item/Asset"
{
    Caption = 'Required Item/Asset';
    PageType = Card;
    SourceTable = "Required Item/Asset";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field("Required by"; Rec."Required by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required by field.';
                }
                group(RD)
                {
                    ShowCaption = false;
                    Visible = (Rec.Status = Rec.Status::Faulty) or (Rec.Status = Rec.Status::Provided);
                    field("Date Provided"; Rec."Date Provided")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Date Provided field.';
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

}
