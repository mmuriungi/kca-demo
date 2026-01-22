report 50219 "Programmes Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Programmes Listing.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programmes_ListingCaption; Programmes_ListingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                RequestFilterFields = "Code";
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages_Description; Description)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
                {
                    DataItemLink = "Programme Code" = FIELD("Programme Code"),
                                   "Stage Code" = FIELD(Code);
                    column(Units_Subjects_Code; Code)
                    {
                    }
                    column(Units_Subjects_Desription; Desription)
                    {
                    }
                    column(Units_Subjects__Unit_Type_; "Unit Type")
                    {
                    }
                    column(Units_Subjects_DesriptionCaption; FIELDCAPTION(Desription))
                    {
                    }
                    column(Units_Subjects_CodeCaption; FIELDCAPTION(Code))
                    {
                    }
                    column(Units_Subjects__Unit_Type_Caption; FIELDCAPTION("Unit Type"))
                    {
                    }
                    column(Units_Subjects_Programme_Code; "Programme Code")
                    {
                    }
                    column(Units_Subjects_Stage_Code; "Stage Code")
                    {
                    }
                    column(Units_Subjects_Entry_No; "Entry No")
                    {
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Programmes_ListingCaptionLbl: Label 'Programmes Listing';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

