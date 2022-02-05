## code to prepare `DATASET` dataset goes here

usethis::use_data(DATASET, overwrite = TRUE)

.dat<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.dat.xlsx")
usethis::use_data(.dat,compress = "xz",overwrite = TRUE)

.bmt<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.bmt.xlsx")
usethis::use_data(.bmt,compress = "xz",overwrite = TRUE)

.burn<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.burn.xlsx")
usethis::use_data(.burn,compress = "xz",overwrite = TRUE)

.cha<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.cha.xlsx")
usethis::use_data(.cha,compress = "xz",overwrite = TRUE)

.cle<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.cle.xlsx")
usethis::use_data(.cle,compress = "xz",overwrite = TRUE)

.disp<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.disp.xlsx")
usethis::use_data(.disp,compress = "xz",overwrite = TRUE)

.sol<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.sol.xlsx")
usethis::use_data(.sol,compress = "xz",overwrite = TRUE)

.veg<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.veg.xlsx")
usethis::use_data(.veg,compress = "xz",overwrite = TRUE)

.wet<-readxl::read_excel("D:/Modeling/Formation_STEP/2D_step_fredi/0-data/step_2d_simu/step2d_workspace/Input_sol_and_other/.wet.xlsx")
usethis::use_data(.wet,compress = "xz",overwrite = TRUE)
