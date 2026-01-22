page 51534 "Design Request"
{
    Caption = 'Design Request';
    CardPageId = "Design Request Card";
    PageType = List;
    SourceTable = "Graphics Desing Request";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Desing Req Code"; Rec."Desing Req Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desing Req Code field.';
                }
                field("Desinger Allocated"; Rec."Desinger Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desinger Allocated field.';
                }
                field("Desinger Names"; Rec."Desinger Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desinger Names field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("Requestor Name"; Rec."Requestor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requestor Name field.';
                }
                field("Requestor Staff ID"; Rec."Requestor Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requestor Staff ID field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
            }
        }
    }
}
