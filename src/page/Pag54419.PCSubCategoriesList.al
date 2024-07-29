page 54419 "PC SubCategories List"
{
    ApplicationArea = All;
    Caption = 'PC SubCategories List';
    PageType = List;
    SourceTable = "PC SubCategories Setup";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Activities';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }
            }
        }
    }
}
