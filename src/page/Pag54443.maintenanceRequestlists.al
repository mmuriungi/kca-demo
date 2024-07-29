page 54443 "maintenance Request lists"
{
    Caption = 'maintenance Requests';
    PageType = List;
    SourceTable = "maintenance Request list2";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(" Maintenance Descriptions"; Rec." Maintenance Descriptions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Maintenance Descriptions field.', Comment = '%';
                }
            }
        }
    }
}
