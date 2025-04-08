page 50225 "Risk Type"
{
    ApplicationArea = All;
    Caption = 'Risk Type';
    PageType = List;
    SourceTable = "Risk Type";
    UsageCategory = Lists;
    //
    layout
    {

        area(content)
        {
            repeater(General)
            {

                field("Entry No"; "Entry No")
                {
                    Editable = false;

                }
                field("Risk Type"; "Risk Type")
                {
                    // MultiLine = true;
                }
                field("Risk Type Description"; "Risk Type Description")
                {
                    // MultiLine = true;
                }

            }
        }
    }


}
