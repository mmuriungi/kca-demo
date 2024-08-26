page 51915 "REG-Registry Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(MailReg)
            {
                part(MailRegList; "REG-Mail Register List")
                {
                    ApplicationArea = All;
                }
            }
            group(tr)
            {
                ShowCaption = false;
                part(HOD; "Approvals Activities One")
                {
                    ApplicationArea = Suite;
                }
                part(Registra; "Approvals Activities Three")
                {
                    ApplicationArea = Suite;
                }
            }
        }
    }

    actions
    {
        area(sections)
        {
            group(Registry)
            {
                action("File Cabinet")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Sections List";
                }

                action("Registry Files")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Files List";
                }

                action("File Movement Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Movement List";
                }
                action("Bring Up")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Move BringUp";
                    RunPageLink = "Issued Out" = filter(true);
                }
                action("File Movement History")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Move History";
                    //RunPageLink = "Folio Returned" = filter(true);
                }
                action("Inward Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Inward Register B";
                }
                action("Outward Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Outward Register List";
                }
                action("Closed Files")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Closed Files Lst";
                }
            }
            group("Archives Register")
            {
                action("File Appraisal Reqests")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Appraisal Req";
                }
                action("Archives")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Archive Register";
                }
                action("Destroy File(s)")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-MarkedforDest";
                }
                action("Destruction History")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-FileDestruction History";
                }

                action("Mail Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Mail Register List";
                }
                action("Registry Files List")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Registry Files List";
                }
                action("File Requisition List")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Requisition List";
                }
                action("File Request Reasons")
                {
                    RunObject = Page "REG-File Request Reasons";
                    ApplicationArea = All;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                    ApplicationArea = All;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                    ApplicationArea = All;
                }
                action("File Requisitions")
                {
                    Image = Register;

                    RunObject = Page "REG-File Requisition List";
                    ApplicationArea = All;
                }
                action("Purchase Requisition Header")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = page "Purchase Requisition Header";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }
                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }

            }

        }

        area(embedding)
        {
            /* action("File Cabinet List")
                {
                    ApplicationArea = All;
                    
                    RunObject = Page "File Cabinet List";
                } */
        }
    }

}

