
(deftemplate ioproxy ; шаблон факта-посредника для обмена информацией с GUI
	(slot message (default none))
)

(deffacts proxy-fact ; экземпляр факта ioproxy
	(ioproxy
		(message none)
	)
)

(defrule clear-message
	(declare (salience 90))
	?clear-msg-flg <- (clearmessage)
	?sendmessage <- (sendmessagehalt ?msg)
	=>
	(retract ?clear-msg-flg)
	(retract ?sendmessage)
)

(defrule set-output-and-halt
	(declare (salience 99))
	?current-message <- (sendmessagehalt ?new-msg)
	?proxy <- (ioproxy (message ?msg))
	=>
	(modify ?proxy (message ?new-msg))
	(retract ?current-message)
	(halt)
)

;================================================

(deftemplate fact ; Шаблон факта
	(slot id (default none))  ; Название
	(slot name (default none))  ; Название
	(slot assurance (default 0.8)) ; Уверенность в том, что данный факт имеет место быть (e.g. вероятность)
)

(defrule Rule_1_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(not (exists (fact (id 5) (name ветер) ) ))
	=>
	(assert (fact (id 5) (name ветер)(assurance ?a0)))
	(assert(sendmessagehalt " Воздух + Воздух = Ветер|ветер|"))
	(halt)
)
(defrule Rule_1_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	?f<-(fact (id 5) (name ветер) (assurance ?a))
	?newA<-(* ?a0 1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_2_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(not (exists (fact (id 6) (name давление) ) ))
	=>
	(assert (fact (id 6) (name давление)(assurance ?a0)))
	(assert(sendmessagehalt " Земля + Земля = Давление |давление|"))
	(halt)
)
(defrule Rule_2_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	?f<-(fact (id 6) (name давление) (assurance ?a))
	?newA<-(* ?a0 1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_3_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	(not (exists (fact (id 7) (name спирт) ) ))
	=>
	(assert (fact (id 7) (name спирт)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Вода = Спирт|спирт|"))
	(halt)
)
(defrule Rule_3_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	?f<-(fact (id 7) (name спирт) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_4_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(not (exists (fact (id 8) (name море) ) ))
	=>
	(assert (fact (id 8) (name море)(assurance ?a0)))
	(assert(sendmessagehalt " Вода + Вода = Море|море|"))
	(halt)
)
(defrule Rule_4_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	?f<-(fact (id 8) (name море) (assurance ?a))
	?newA<-(* ?a0 1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_5_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	(not (exists (fact (id 9) (name пар) ) ))
	=>
	(assert (fact (id 9) (name пар)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Воздух = Пар |пар|"))
	(halt)
)
(defrule Rule_5_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	?f<-(fact (id 9) (name пар) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_6_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	(not (exists (fact (id 10) (name лава) ) ))
	=>
	(assert (fact (id 10) (name лава)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Земля = Лава|лава|"))
	(halt)
)
(defrule Rule_6_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	?f<-(fact (id 10) (name лава) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_7_A
	(declare (salience 40))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 10) (name лава) (assurance ?a1))
	(not (exists (fact (id 11) (name вулкан) ) ))
	=>
	(assert (fact (id 11) (name вулкан)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Лава + Давление = Вулкан|вулкан|"))
	(halt)
)
(defrule Rule_7_B
	(declare (salience 50))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 10) (name лава) (assurance ?a1))
	?f<-(fact (id 11) (name вулкан) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_8_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	(not (exists (fact (id 12) (name болото) ) ))
	=>
	(assert (fact (id 12) (name болото)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Земля = Болото|болото|"))
	(halt)
)
(defrule Rule_8_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	?f<-(fact (id 12) (name болото) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_9_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 10) (name лава) (assurance ?a1))
	(not (exists (fact (id 13) (name камень) ) ))
	=>
	(assert (fact (id 13) (name камень)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Лава = Камень|камень|"))
	(halt)
)
(defrule Rule_9_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 10) (name лава) (assurance ?a1))
	?f<-(fact (id 13) (name камень) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_10_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	(not (exists (fact (id 14) (name металл) ) ))
	=>
	(assert (fact (id 14) (name металл)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Камень = Металл|металл|"))
	(halt)
)
(defrule Rule_10_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	?f<-(fact (id 14) (name металл) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_11_A
	(declare (salience 40))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 12) (name болото) (assurance ?a1))
	(not (exists (fact (id 15) (name торф) ) ))
	=>
	(assert (fact (id 15) (name торф)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Давление + Болото = Торф|торф|"))
	(halt)
)
(defrule Rule_11_B
	(declare (salience 50))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 12) (name болото) (assurance ?a1))
	?f<-(fact (id 15) (name торф) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_12_A
	(declare (salience 40))
	(fact (id 9) (name пар) (assurance ?a0))
	(fact (id 14) (name металл) (assurance ?a1))
	(not (exists (fact (id 17) (name паровой_котел) ) ))
	=>
	(assert (fact (id 17) (name паровой_котел)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Металл + Пар = Паровой котел|паровой котел|"))
	(halt)
)
(defrule Rule_12_B
	(declare (salience 50))
	(fact (id 9) (name пар) (assurance ?a0))
	(fact (id 14) (name металл) (assurance ?a1))
	?f<-(fact (id 17) (name паровой_котел) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_13_A
	(declare (salience 40))
	(fact (id 5) (name ветер) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	(not (exists (fact (id 18) (name песок) ) ))
	=>
	(assert (fact (id 18) (name песок)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Камень + Ветер = Песок|песок|"))
	(halt)
)
(defrule Rule_13_B
	(declare (salience 50))
	(fact (id 5) (name ветер) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	?f<-(fact (id 18) (name песок) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_14_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	(not (exists (fact (id 19) (name пляж) ) ))
	=>
	(assert (fact (id 19) (name пляж)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Песок = Пляж|пляж|"))
	(halt)
)
(defrule Rule_14_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	?f<-(fact (id 19) (name пляж) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_15_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	(not (exists (fact (id 20) (name пыль) ) ))
	=>
	(assert (fact (id 20) (name пыль)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Воздух = Пыль|пыль|"))
	(halt)
)
(defrule Rule_15_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	?f<-(fact (id 20) (name пыль) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_16_A
	(declare (salience 40))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 11) (name вулкан) (assurance ?a1))
	(not (exists (fact (id 21) (name пепел) ) ))
	=>
	(assert (fact (id 21) (name пепел)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вулкан + Давление = Пепел|пепел|"))
	(halt)
)
(defrule Rule_16_B
	(declare (salience 50))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 11) (name вулкан) (assurance ?a1))
	?f<-(fact (id 21) (name пепел) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_17_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 20) (name пыль) (assurance ?a1))
	(not (exists (fact (id 22) (name порох) ) ))
	=>
	(assert (fact (id 22) (name порох)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Пыль = Порох|порох|"))
	(halt)
)
(defrule Rule_17_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 20) (name пыль) (assurance ?a1))
	?f<-(fact (id 22) (name порох) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_18_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	(not (exists (fact (id 23) (name гейзер) ) ))
	=>
	(assert (fact (id 23) (name гейзер)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Пар + Земля = Гейзер|гейзер|"))
	(halt)
)
(defrule Rule_18_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	?f<-(fact (id 23) (name гейзер) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_19_A
	(declare (salience 40))
	(fact (id 18) (name песок) (assurance ?a0))
	(not (exists (fact (id 24) (name пустыня) ) ))
	=>
	(assert (fact (id 24) (name пустыня)(assurance ?a0)))
	(assert(sendmessagehalt " Песок + Песок = Пустыня|пустыня|"))
	(halt)
)
(defrule Rule_19_B
	(declare (salience 50))
	(fact (id 18) (name песок) (assurance ?a0))
	?f<-(fact (id 24) (name пустыня) (assurance ?a))
	?newA<-(* ?a0 1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_20_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 20) (name пыль) (assurance ?a1))
	(not (exists (fact (id 25) (name грязь) ) ))
	=>
	(assert (fact (id 25) (name грязь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Пыль = Грязь|грязь|"))
	(halt)
)
(defrule Rule_20_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 20) (name пыль) (assurance ?a1))
	?f<-(fact (id 25) (name грязь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_21_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 15) (name торф) (assurance ?a1))
	(not (exists (fact (id 26) (name дым) ) ))
	=>
	(assert (fact (id 26) (name дым)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Торф = Дым|дым|"))
	(halt)
)
(defrule Rule_21_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 15) (name торф) (assurance ?a1))
	?f<-(fact (id 26) (name дым) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_22_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	(not (exists (fact (id 27) (name энергия) ) ))
	=>
	(assert (fact (id 27) (name энергия)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Воздух = Энергия|энергия|"))
	(halt)
)
(defrule Rule_22_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	?f<-(fact (id 27) (name энергия) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_23_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	(not (exists (fact (id 28) (name буря) ) ))
	=>
	(assert (fact (id 28) (name буря)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Энергия + Воздух = Буря|буря|"))
	(halt)
)
(defrule Rule_23_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	?f<-(fact (id 28) (name буря) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_24_A
	(declare (salience 40))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	(not (exists (fact (id 29) (name глина) ) ))
	=>
	(assert (fact (id 29) (name глина)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Песок + Болото = Глина|глина|"))
	(halt)
)
(defrule Rule_24_B
	(declare (salience 50))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	?f<-(fact (id 29) (name глина) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_25_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 5) (name ветер) (assurance ?a1))
	(not (exists (fact (id 30) (name звук) ) ))
	=>
	(assert (fact (id 30) (name звук)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Ветер + Металл = Звук|звук|"))
	(halt)
)
(defrule Rule_25_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 5) (name ветер) (assurance ?a1))
	?f<-(fact (id 30) (name звук) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_26_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	(not (exists (fact (id 31) (name облако) ) ))
	=>
	(assert (fact (id 31) (name облако)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Пар = Облако |облако|"))
	(halt)
)
(defrule Rule_26_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	?f<-(fact (id 31) (name облако) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_27_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 31) (name облако) (assurance ?a1))
	(not (exists (fact (id 32) (name небо) ) ))
	=>
	(assert (fact (id 32) (name небо)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Облако = Небо|небо|"))
	(halt)
)
(defrule Rule_27_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 31) (name облако) (assurance ?a1))
	?f<-(fact (id 32) (name небо) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_28_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 29) (name глина) (assurance ?a1))
	(not (exists (fact (id 33) (name кирпич) ) ))
	=>
	(assert (fact (id 33) (name кирпич)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Глина = Кирпич|кирпич|"))
	(halt)
)
(defrule Rule_28_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 29) (name глина) (assurance ?a1))
	?f<-(fact (id 33) (name кирпич) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_29_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	(not (exists (fact (id 34) (name стекло) ) ))
	=>
	(assert (fact (id 34) (name стекло)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Песок + Огонь = Стекло|стекло|"))
	(halt)
)
(defrule Rule_29_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 18) (name песок) (assurance ?a1))
	?f<-(fact (id 34) (name стекло) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_30_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 33) (name кирпич) (assurance ?a1))
	(not (exists (fact (id 35) (name плотина) ) ))
	=>
	(assert (fact (id 35) (name плотина)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Кирпич = Плотина|плотина|"))
	(halt)
)
(defrule Rule_30_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 33) (name кирпич) (assurance ?a1))
	?f<-(fact (id 35) (name плотина) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_31_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 22) (name порох) (assurance ?a1))
	(not (exists (fact (id 36) (name взрыв) ) ))
	=>
	(assert (fact (id 36) (name взрыв)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Порох + Огонь = Взрыв|взрыв|"))
	(halt)
)
(defrule Rule_31_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 22) (name порох) (assurance ?a1))
	?f<-(fact (id 36) (name взрыв) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_32_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 7) (name спирт) (assurance ?a1))
	(not (exists (fact (id 37) (name водка) ) ))
	=>
	(assert (fact (id 37) (name водка)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Спирт = Водка |водка|"))
	(halt)
)
(defrule Rule_32_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 7) (name спирт) (assurance ?a1))
	?f<-(fact (id 37) (name водка) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_33_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	(not (exists (fact (id 38) (name лед) ) ))
	=>
	(assert (fact (id 38) (name лед)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Стекло = Лед|лед|"))
	(halt)
)
(defrule Rule_33_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	?f<-(fact (id 38) (name лед) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_34_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	(not (exists (fact (id 39) (name лампа) ) ))
	=>
	(assert (fact (id 39) (name лампа)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Стекло = Лампа|лампа|"))
	(halt)
)
(defrule Rule_34_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	?f<-(fact (id 39) (name лампа) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_35_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	(not (exists (fact (id 40) (name электричество) ) ))
	=>
	(assert (fact (id 40) (name электричество)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Металл + Энергия = Электричество |электричество|"))
	(halt)
)
(defrule Rule_35_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	?f<-(fact (id 40) (name электричество) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_36_A
	(declare (salience 40))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	(not (exists (fact (id 41) (name жизнь) ) ))
	=>
	(assert (fact (id 41) (name жизнь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Болото + Энергия = Жизнь|жизнь|"))
	(halt)
)
(defrule Rule_36_B
	(declare (salience 50))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	?f<-(fact (id 41) (name жизнь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_37_A
	(declare (salience 40))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 42) (name бактерии) ) ))
	=>
	(assert (fact (id 42) (name бактерии)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Болото + Жизнь = Бактерии|бактерии|"))
	(halt)
)
(defrule Rule_37_B
	(declare (salience 50))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 42) (name бактерии) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_38_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 43) (name водоросли) ) ))
	=>
	(assert (fact (id 43) (name водоросли)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Жизнь = Водоросли|водоросли|"))
	(halt)
)
(defrule Rule_38_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 43) (name водоросли) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_39_A
	(declare (salience 40))
	(fact (id 29) (name глина) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 44) (name голем) ) ))
	=>
	(assert (fact (id 44) (name голем)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Глина + Жизнь = Голем|голем|"))
	(halt)
)
(defrule Rule_39_B
	(declare (salience 50))
	(fact (id 29) (name глина) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 44) (name голем) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_40_A
	(declare (salience 40))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 44) (name голем) (assurance ?a1))
	(not (exists (fact (id 45) (name человек) ) ))
	=>
	(assert (fact (id 45) (name человек)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Голем + Жизнь = Человек |человек|"))
	(halt)
)
(defrule Rule_40_B
	(declare (salience 50))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 44) (name голем) (assurance ?a1))
	?f<-(fact (id 45) (name человек) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_41_A
	(declare (salience 40))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 46) (name хижина) ) ))
	=>
	(assert (fact (id 46) (name хижина)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Камень = Хижина|хижина|"))
	(halt)
)
(defrule Rule_41_B
	(declare (salience 50))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 46) (name хижина) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_42_A
	(declare (salience 40))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 47) (name яйцо) ) ))
	=>
	(assert (fact (id 47) (name яйцо)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Камень + Жизнь = Яйцо|яйцо|"))
	(halt)
)
(defrule Rule_42_B
	(declare (salience 50))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 47) (name яйцо) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_43_A
	(declare (salience 40))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	(not (exists (fact (id 48) (name курица) ) ))
	=>
	(assert (fact (id 48) (name курица)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Жизнь + Яйцо = Курица|курица|"))
	(halt)
)
(defrule Rule_43_B
	(declare (salience 50))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	?f<-(fact (id 48) (name курица) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_44_A
	(declare (salience 40))
	(fact (id 47) (name яйцо) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	(not (exists (fact (id 49) (name дилемма) ) ))
	=>
	(assert (fact (id 49) (name дилемма)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Яйцо + Курица = Дилемма|дилемма|"))
	(halt)
)
(defrule Rule_44_B
	(declare (salience 50))
	(fact (id 47) (name яйцо) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	?f<-(fact (id 49) (name дилемма) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_45_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 50) (name металлический_голем) ) ))
	=>
	(assert (fact (id 50) (name металлический_голем)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Металл + Жизнь = Металлический голем|металлический голем|"))
	(halt)
)
(defrule Rule_45_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 50) (name металлический_голем) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_46_A
	(declare (salience 40))
	(fact (id 10) (name лава) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 51) (name лавовый_голем) ) ))
	=>
	(assert (fact (id 51) (name лавовый_голем)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Лава + Жизнь = Лавовый голем|лавовый голем|"))
	(halt)
)
(defrule Rule_46_B
	(declare (salience 50))
	(fact (id 10) (name лава) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 51) (name лавовый_голем) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_47_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 52) (name огненный_элементал) ) ))
	=>
	(assert (fact (id 52) (name огненный_элементал)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Жизнь = Огненный голем|огненный элементал|"))
	(halt)
)
(defrule Rule_47_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 52) (name огненный_элементал) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_48_A
	(declare (salience 40))
	(fact (id 21) (name пепел) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 53) (name призрак) ) ))
	=>
	(assert (fact (id 53) (name призрак)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Пепел + Жизнь = Призрак|призрак|"))
	(halt)
)
(defrule Rule_48_B
	(declare (salience 50))
	(fact (id 21) (name пепел) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 53) (name призрак) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_49_A
	(declare (salience 40))
	(fact (id 18) (name песок) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 54) (name семена) ) ))
	=>
	(assert (fact (id 54) (name семена)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Песок + Жизнь = Семена|семена|"))
	(halt)
)
(defrule Rule_49_B
	(declare (salience 50))
	(fact (id 18) (name песок) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 54) (name семена) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_50_A
	(declare (salience 40))
	(fact (id 40) (name электричество) (assurance ?a0))
	(fact (id 50) (name металлический_голем) (assurance ?a1))
	(not (exists (fact (id 55) (name робот) ) ))
	=>
	(assert (fact (id 55) (name робот)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Металлический голем + Электричество = Робот|робот|"))
	(halt)
)
(defrule Rule_50_B
	(declare (salience 50))
	(fact (id 40) (name электричество) (assurance ?a0))
	(fact (id 50) (name металлический_голем) (assurance ?a1))
	?f<-(fact (id 55) (name робот) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_51_A
	(declare (salience 40))
	(fact (id 46) (name хижина) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	(not (exists (fact (id 56) (name курятник) ) ))
	=>
	(assert (fact (id 56) (name курятник)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Хижина + Курица = Курятник|курятник|"))
	(halt)
)
(defrule Rule_51_B
	(declare (salience 50))
	(fact (id 46) (name хижина) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	?f<-(fact (id 56) (name курятник) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_52_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 43) (name водоросли) (assurance ?a1))
	(not (exists (fact (id 57) (name гриб) ) ))
	=>
	(assert (fact (id 57) (name гриб)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Водоросли + Земля = Гриб|гриб|"))
	(halt)
)
(defrule Rule_52_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 43) (name водоросли) (assurance ?a1))
	?f<-(fact (id 57) (name гриб) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_53_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	(not (exists (fact (id 58) (name динозавр) ) ))
	=>
	(assert (fact (id 58) (name динозавр)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Яйцо = Динозавр|динозавр|"))
	(halt)
)
(defrule Rule_53_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	?f<-(fact (id 58) (name динозавр) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_54_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 59) (name инструменты) ) ))
	=>
	(assert (fact (id 59) (name инструменты)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Металл = Инструменты|инструменты|"))
	(halt)
)
(defrule Rule_54_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 59) (name инструменты) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_55_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 59) (name инструменты) (assurance ?a1))
	(not (exists (fact (id 60) (name оружие) ) ))
	=>
	(assert (fact (id 60) (name оружие)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Металл = Оружие|оружие|"))
	(halt)
)
(defrule Rule_55_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 59) (name инструменты) (assurance ?a1))
	?f<-(fact (id 60) (name оружие) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_56_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 54) (name семена) (assurance ?a1))
	(not (exists (fact (id 61) (name дерево) ) ))
	=>
	(assert (fact (id 61) (name дерево)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Семена = Дерево|дерево|"))
	(halt)
)
(defrule Rule_56_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 54) (name семена) (assurance ?a1))
	?f<-(fact (id 61) (name дерево) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_57_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	(not (exists (fact (id 62) (name уголь) ) ))
	=>
	(assert (fact (id 62) (name уголь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Дерево = Уголь|уголь|"))
	(halt)
)
(defrule Rule_57_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	?f<-(fact (id 62) (name уголь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_58_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 63) (name труп) ) ))
	=>
	(assert (fact (id 63) (name труп)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Огонь = Труп|труп|"))
	(halt)
)
(defrule Rule_58_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 63) (name труп) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_59_A
	(declare (salience 40))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 63) (name труп) (assurance ?a1))
	(not (exists (fact (id 64) (name зомби) ) ))
	=>
	(assert (fact (id 64) (name зомби)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Жизнь + Труп = Зомби|зомби|"))
	(halt)
)
(defrule Rule_59_B
	(declare (salience 50))
	(fact (id 41) (name жизнь) (assurance ?a0))
	(fact (id 63) (name труп) (assurance ?a1))
	?f<-(fact (id 64) (name зомби) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_60_A
	(declare (salience 40))
	(fact (id 37) (name водка) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 65) (name алкаш) ) ))
	=>
	(assert (fact (id 65) (name алкаш)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Водка = Алкаш |алкаш|"))
	(halt)
)
(defrule Rule_60_B
	(declare (salience 50))
	(fact (id 37) (name водка) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 65) (name алкаш) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_61_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 63) (name труп) (assurance ?a1))
	(not (exists (fact (id 66) (name могила) ) ))
	=>
	(assert (fact (id 66) (name могила)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Труп + Земля = Могила|могила|"))
	(halt)
)
(defrule Rule_61_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 63) (name труп) (assurance ?a1))
	?f<-(fact (id 66) (name могила) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_62_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	(not (exists (fact (id 67) (name курица-гриль) ) ))
	=>
	(assert (fact (id 67) (name курица-гриль)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Курица = Курица-гриль|курица-гриль|"))
	(halt)
)
(defrule Rule_62_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 48) (name курица) (assurance ?a1))
	?f<-(fact (id 67) (name курица-гриль) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_63_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	(not (exists (fact (id 68) (name птица) ) ))
	=>
	(assert (fact (id 68) (name птица)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Яйцо = Птица|птица|"))
	(halt)
)
(defrule Rule_63_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	?f<-(fact (id 68) (name птица) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_64_A
	(declare (salience 40))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	(not (exists (fact (id 69) (name ящерица) ) ))
	=>
	(assert (fact (id 69) (name ящерица)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Яйцо + Болото = Ящерица|ящерица|"))
	(halt)
)
(defrule Rule_64_B
	(declare (salience 50))
	(fact (id 12) (name болото) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	?f<-(fact (id 69) (name ящерица) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_65_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 69) (name ящерица) (assurance ?a1))
	(not (exists (fact (id 70) (name зверь) ) ))
	=>
	(assert (fact (id 70) (name зверь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Ящерица + Земля = Зверь|зверь|"))
	(halt)
)
(defrule Rule_65_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 69) (name ящерица) (assurance ?a1))
	?f<-(fact (id 70) (name зверь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_66_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	(not (exists (fact (id 71) (name кит) ) ))
	=>
	(assert (fact (id 71) (name кит)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Зверь + Вода = Кит |кит|"))
	(halt)
)
(defrule Rule_66_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	?f<-(fact (id 71) (name кит) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_67_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	(not (exists (fact (id 72) (name домашний_скот) ) ))
	=>
	(assert (fact (id 72) (name домашний_скот)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Зверь + Человек = Домашний скот|домашний скот|"))
	(halt)
)
(defrule Rule_67_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	?f<-(fact (id 72) (name домашний_скот) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_68_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	(not (exists (fact (id 73) (name молоко) ) ))
	=>
	(assert (fact (id 73) (name молоко)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Домашний скот = Молоко|молоко|"))
	(halt)
)
(defrule Rule_68_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	?f<-(fact (id 73) (name молоко) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_69_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	(not (exists (fact (id 89) (name мясо) ) ))
	=>
	(assert (fact (id 89) (name мясо)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Домашний скот = Мясо|мясо|"))
	(halt)
)
(defrule Rule_69_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	?f<-(fact (id 89) (name мясо) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_70_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	(not (exists (fact (id 90) (name шерсть) ) ))
	=>
	(assert (fact (id 90) (name шерсть)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Домашний скот = Шерсть|шерсть|"))
	(halt)
)
(defrule Rule_70_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 72) (name домашний_скот) (assurance ?a1))
	?f<-(fact (id 90) (name шерсть) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_71_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 73) (name молоко) (assurance ?a1))
	(not (exists (fact (id 74) (name женщина) ) ))
	=>
	(assert (fact (id 74) (name женщина)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Молоко + Человек = Женщина|женщина|"))
	(halt)
)
(defrule Rule_71_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 73) (name молоко) (assurance ?a1))
	?f<-(fact (id 74) (name женщина) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_72_A
	(declare (salience 40))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 68) (name птица) (assurance ?a1))
	(not (exists (fact (id 75) (name самолет) ) ))
	=>
	(assert (fact (id 75) (name самолет)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Металл + Птица = Самолет|самолет|"))
	(halt)
)
(defrule Rule_72_B
	(declare (salience 50))
	(fact (id 14) (name металл) (assurance ?a0))
	(fact (id 68) (name птица) (assurance ?a1))
	?f<-(fact (id 75) (name самолет) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_73_A
	(declare (salience 40))
	(fact (id 54) (name семена) (assurance ?a0))
	(fact (id 25) (name грязь) (assurance ?a1))
	(not (exists (fact (id 76) (name цветок) ) ))
	=>
	(assert (fact (id 76) (name цветок)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Семена + Грязь = Цветок |цветок|"))
	(halt)
)
(defrule Rule_73_B
	(declare (salience 50))
	(fact (id 54) (name семена) (assurance ?a0))
	(fact (id 25) (name грязь) (assurance ?a1))
	?f<-(fact (id 76) (name цветок) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_74_A
	(declare (salience 40))
	(fact (id 24) (name пустыня) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	(not (exists (fact (id 77) (name верблюд) ) ))
	=>
	(assert (fact (id 77) (name верблюд)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Пустыня + Зверь = Верблюд|верблюд|"))
	(halt)
)
(defrule Rule_74_B
	(declare (salience 50))
	(fact (id 24) (name пустыня) (assurance ?a0))
	(fact (id 70) (name зверь) (assurance ?a1))
	?f<-(fact (id 77) (name верблюд) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_75_A
	(declare (salience 40))
	(fact (id 25) (name грязь) (assurance ?a0))
	(fact (id 57) (name гриб) (assurance ?a1))
	(not (exists (fact (id 78) (name плесень) ) ))
	=>
	(assert (fact (id 78) (name плесень)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Грязь + Гриб = Плесень|плесень|"))
	(halt)
)
(defrule Rule_75_B
	(declare (salience 50))
	(fact (id 25) (name грязь) (assurance ?a0))
	(fact (id 57) (name гриб) (assurance ?a1))
	?f<-(fact (id 78) (name плесень) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_76_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 42) (name бактерии) (assurance ?a1))
	(not (exists (fact (id 1) (name вода) ) ))
	=>
	(assert (fact (id 1) (name вода)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вода + Бактерии = Планктон |вода|"))
	(halt)
)
(defrule Rule_76_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 42) (name бактерии) (assurance ?a1))
	?f<-(fact (id 1) (name вода) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_77_A
	(declare (salience 40))
	(fact (id 80) (name дракон) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 21) (name пепел) ) ))
	=>
	(assert (fact (id 21) (name пепел)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Дракон + Человек = Пепел|пепел|"))
	(halt)
)
(defrule Rule_77_B
	(declare (salience 50))
	(fact (id 80) (name дракон) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 21) (name пепел) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_78_A
	(declare (salience 40))
	(fact (id 19) (name пляж) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	(not (exists (fact (id 81) (name черепаха) ) ))
	=>
	(assert (fact (id 81) (name черепаха)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Пляж + Яйцо = Черепаха|черепаха|"))
	(halt)
)
(defrule Rule_78_B
	(declare (salience 50))
	(fact (id 19) (name пляж) (assurance ?a0))
	(fact (id 47) (name яйцо) (assurance ?a1))
	?f<-(fact (id 81) (name черепаха) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_79_A
	(declare (salience 40))
	(fact (id 53) (name призрак) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	(not (exists (fact (id 82) (name эктоплазма) ) ))
	=>
	(assert (fact (id 82) (name эктоплазма)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Призрак + Энергия = Эктоплазма |эктоплазма|"))
	(halt)
)
(defrule Rule_79_B
	(declare (salience 50))
	(fact (id 53) (name призрак) (assurance ?a0))
	(fact (id 27) (name энергия) (assurance ?a1))
	?f<-(fact (id 82) (name эктоплазма) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_80_A
	(declare (salience 40))
	(fact (id 61) (name дерево) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	(not (exists (fact (id 83) (name энты) ) ))
	=>
	(assert (fact (id 83) (name энты)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Дерево + Жизнь = Энты|энты|"))
	(halt)
)
(defrule Rule_80_B
	(declare (salience 50))
	(fact (id 61) (name дерево) (assurance ?a0))
	(fact (id 41) (name жизнь) (assurance ?a1))
	?f<-(fact (id 83) (name энты) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_81_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 42) (name бактерии) (assurance ?a1))
	(not (exists (fact (id 84) (name грипп) ) ))
	=>
	(assert (fact (id 84) (name грипп)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Бактерии = Грипп |грипп|"))
	(halt)
)
(defrule Rule_81_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 42) (name бактерии) (assurance ?a1))
	?f<-(fact (id 84) (name грипп) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_82_A
	(declare (salience 40))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 40) (name электричество) (assurance ?a1))
	(not (exists (fact (id 85) (name озон) ) ))
	=>
	(assert (fact (id 85) (name озон)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Воздух + Электричество = Озон |озон|"))
	(halt)
)
(defrule Rule_82_B
	(declare (salience 50))
	(fact (id 4) (name воздух) (assurance ?a0))
	(fact (id 40) (name электричество) (assurance ?a1))
	?f<-(fact (id 85) (name озон) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_83_A
	(declare (salience 40))
	(fact (id 40) (name электричество) (assurance ?a0))
	(fact (id 64) (name зомби) (assurance ?a1))
	(not (exists (fact (id 86) (name франкенштейн) ) ))
	=>
	(assert (fact (id 86) (name франкенштейн)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Электричество + Зомби = Франкенштейн|франкенштейн|"))
	(halt)
)
(defrule Rule_83_B
	(declare (salience 50))
	(fact (id 40) (name электричество) (assurance ?a0))
	(fact (id 64) (name зомби) (assurance ?a1))
	?f<-(fact (id 86) (name франкенштейн) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_84_A
	(declare (salience 40))
	(fact (id 63) (name труп) (assurance ?a0))
	(fact (id 68) (name птица) (assurance ?a1))
	(not (exists (fact (id 87) (name гриф) ) ))
	=>
	(assert (fact (id 87) (name гриф)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Труп + Птица = Гриф|гриф|"))
	(halt)
)
(defrule Rule_84_B
	(declare (salience 50))
	(fact (id 63) (name труп) (assurance ?a0))
	(fact (id 68) (name птица) (assurance ?a1))
	?f<-(fact (id 87) (name гриф) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_85_A
	(declare (salience 40))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	(not (exists (fact (id 88) (name статуя) ) ))
	=>
	(assert (fact (id 88) (name статуя)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Камень = Статуя |статуя|"))
	(halt)
)
(defrule Rule_85_B
	(declare (salience 50))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	?f<-(fact (id 88) (name статуя) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_86_A
	(declare (salience 40))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 89) (name мясо) (assurance ?a1))
	(not (exists (fact (id 91) (name нож) ) ))
	=>
	(assert (fact (id 91) (name нож)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Мясо = Нож|нож|"))
	(halt)
)
(defrule Rule_86_B
	(declare (salience 50))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 89) (name мясо) (assurance ?a1))
	?f<-(fact (id 91) (name нож) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_87_A
	(declare (salience 40))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	(not (exists (fact (id 93) (name древесина) ) ))
	=>
	(assert (fact (id 93) (name древесина)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Дерево = Древесина|древесина|"))
	(halt)
)
(defrule Rule_87_B
	(declare (salience 50))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	?f<-(fact (id 93) (name древесина) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_88_A
	(declare (salience 40))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 90) (name шерсть) (assurance ?a1))
	(not (exists (fact (id 94) (name ткань) ) ))
	=>
	(assert (fact (id 94) (name ткань)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Шерсть = Ткань|ткань|"))
	(halt)
)
(defrule Rule_88_B
	(declare (salience 50))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 90) (name шерсть) (assurance ?a1))
	?f<-(fact (id 94) (name ткань) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_89_A
	(declare (salience 40))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	(not (exists (fact (id 95) (name колесо) ) ))
	=>
	(assert (fact (id 95) (name колесо)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Инструменты + Древесина = Колесо|колесо|"))
	(halt)
)
(defrule Rule_89_B
	(declare (salience 50))
	(fact (id 59) (name инструменты) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	?f<-(fact (id 95) (name колесо) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_90_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	(not (exists (fact (id 96) (name охотник) ) ))
	=>
	(assert (fact (id 96) (name охотник)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Оружие = Охотник|охотник|"))
	(halt)
)
(defrule Rule_90_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	?f<-(fact (id 96) (name охотник) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_91_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 43) (name водоросли) (assurance ?a1))
	(not (exists (fact (id 97) (name йод) ) ))
	=>
	(assert (fact (id 97) (name йод)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Водоросли = Йод |йод|"))
	(halt)
)
(defrule Rule_91_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 43) (name водоросли) (assurance ?a1))
	?f<-(fact (id 97) (name йод) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_92_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 58) (name динозавр) (assurance ?a1))
	(not (exists (fact (id 98) (name окаменелость) ) ))
	=>
	(assert (fact (id 98) (name окаменелость)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Динозавр = Окаменелость|окаменелость|"))
	(halt)
)
(defrule Rule_92_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 58) (name динозавр) (assurance ?a1))
	?f<-(fact (id 98) (name окаменелость) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_93_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	(not (exists (fact (id 99) (name виноград) ) ))
	=>
	(assert (fact (id 99) (name виноград)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Древесина = Виноград |виноград|"))
	(halt)
)
(defrule Rule_93_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	?f<-(fact (id 99) (name виноград) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_94_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 59) (name инструменты) (assurance ?a1))
	(not (exists (fact (id 100) (name пашня) ) ))
	=>
	(assert (fact (id 100) (name пашня)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Инструменты = Пашня|пашня|"))
	(halt)
)
(defrule Rule_94_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 59) (name инструменты) (assurance ?a1))
	?f<-(fact (id 100) (name пашня) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_95_A
	(declare (salience 40))
	(fact (id 89) (name мясо) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	(not (exists (fact (id 101) (name жареное_мясо) ) ))
	=>
	(assert (fact (id 101) (name жареное_мясо)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Мясо + Огонь = Жареное мясо|жареное мясо|"))
	(halt)
)
(defrule Rule_95_B
	(declare (salience 50))
	(fact (id 89) (name мясо) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	?f<-(fact (id 101) (name жареное_мясо) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_96_A
	(declare (salience 40))
	(fact (id 22) (name порох) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	(not (exists (fact (id 102) (name огнестрельное_оружие) ) ))
	=>
	(assert (fact (id 102) (name огнестрельное_оружие)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Порох + Оружие = Огнестрельное оружие|огнестрельное оружие|"))
	(halt)
)
(defrule Rule_96_B
	(declare (salience 50))
	(fact (id 22) (name порох) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	?f<-(fact (id 102) (name огнестрельное_оружие) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_97_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 102) (name огнестрельное_оружие) (assurance ?a1))
	(not (exists (fact (id 104) (name солдат) ) ))
	=>
	(assert (fact (id 104) (name солдат)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Огнестрельное оружие = Солдат|солдат|"))
	(halt)
)
(defrule Rule_97_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 102) (name огнестрельное_оружие) (assurance ?a1))
	?f<-(fact (id 104) (name солдат) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_98_A
	(declare (salience 40))
	(fact (id 96) (name охотник) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	(not (exists (fact (id 103) (name воин) ) ))
	=>
	(assert (fact (id 103) (name воин)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Охотник + Оружие = Воин|воин|"))
	(halt)
)
(defrule Rule_98_B
	(declare (salience 50))
	(fact (id 96) (name охотник) (assurance ?a0))
	(fact (id 60) (name оружие) (assurance ?a1))
	?f<-(fact (id 103) (name воин) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_99_A
	(declare (salience 40))
	(fact (id 102) (name огнестрельное_оружие) (assurance ?a0))
	(fact (id 103) (name воин) (assurance ?a1))
	(not (exists (fact (id 104) (name солдат) ) ))
	=>
	(assert (fact (id 104) (name солдат)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огнестрельное оружие + Воин = Солдат|солдат|"))
	(halt)
)
(defrule Rule_99_B
	(declare (salience 50))
	(fact (id 102) (name огнестрельное_оружие) (assurance ?a0))
	(fact (id 103) (name воин) (assurance ?a1))
	?f<-(fact (id 104) (name солдат) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_100_A
	(declare (salience 40))
	(fact (id 80) (name дракон) (assurance ?a0))
	(fact (id 103) (name воин) (assurance ?a1))
	(not (exists (fact (id 105) (name кровь) ) ))
	=>
	(assert (fact (id 105) (name кровь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Дракон + Воин = Кровь |кровь|"))
	(halt)
)
(defrule Rule_100_B
	(declare (salience 50))
	(fact (id 80) (name дракон) (assurance ?a0))
	(fact (id 103) (name воин) (assurance ?a1))
	?f<-(fact (id 105) (name кровь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_101_A
	(declare (salience 40))
	(fact (id 95) (name колесо) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	(not (exists (fact (id 106) (name телега) ) ))
	=>
	(assert (fact (id 106) (name телега)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Колесо + Древесина = Телега|телега|"))
	(halt)
)
(defrule Rule_101_B
	(declare (salience 50))
	(fact (id 95) (name колесо) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	?f<-(fact (id 106) (name телега) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_102_A
	(declare (salience 40))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 79) (name планктон) (assurance ?a1))
	(not (exists (fact (id 107) (name червь) ) ))
	=>
	(assert (fact (id 107) (name червь)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Земля + Планктон = Червь|червь|"))
	(halt)
)
(defrule Rule_102_B
	(declare (salience 50))
	(fact (id 3) (name земля) (assurance ?a0))
	(fact (id 79) (name планктон) (assurance ?a1))
	?f<-(fact (id 107) (name червь) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_103_A
	(declare (salience 40))
	(fact (id 107) (name червь) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	(not (exists (fact (id 108) (name бабочка) ) ))
	=>
	(assert (fact (id 108) (name бабочка)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Червь + Воздух = Бабочка|бабочка|"))
	(halt)
)
(defrule Rule_103_B
	(declare (salience 50))
	(fact (id 107) (name червь) (assurance ?a0))
	(fact (id 4) (name воздух) (assurance ?a1))
	?f<-(fact (id 108) (name бабочка) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_104_A
	(declare (salience 40))
	(fact (id 107) (name червь) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	(not (exists (fact (id 109) (name жук) ) ))
	=>
	(assert (fact (id 109) (name жук)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Червь + Земля = Жук|жук|"))
	(halt)
)
(defrule Rule_104_B
	(declare (salience 50))
	(fact (id 107) (name червь) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	?f<-(fact (id 109) (name жук) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_105_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 107) (name червь) (assurance ?a1))
	(not (exists (fact (id 21) (name пепел) ) ))
	=>
	(assert (fact (id 21) (name пепел)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Червь = Пепел|пепел|"))
	(halt)
)
(defrule Rule_105_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 107) (name червь) (assurance ?a1))
	?f<-(fact (id 21) (name пепел) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_106_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 46) (name хижина) (assurance ?a1))
	(not (exists (fact (id 21) (name пепел) ) ))
	=>
	(assert (fact (id 21) (name пепел)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Хижина = Пепел|пепел|"))
	(halt)
)
(defrule Rule_106_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 46) (name хижина) (assurance ?a1))
	?f<-(fact (id 21) (name пепел) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_107_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 83) (name энты) (assurance ?a1))
	(not (exists (fact (id 53) (name призрак) ) ))
	=>
	(assert (fact (id 53) (name призрак)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Огонь + Энты = Призрак|призрак|"))
	(halt)
)
(defrule Rule_107_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 83) (name энты) (assurance ?a1))
	?f<-(fact (id 53) (name призрак) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_108_A
	(declare (salience 40))
	(fact (id 84) (name грипп) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	(not (exists (fact (id 110) (name больной) ) ))
	=>
	(assert (fact (id 110) (name больной)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Грипп + Человек = Больной |больной|"))
	(halt)
)
(defrule Rule_108_B
	(declare (salience 50))
	(fact (id 84) (name грипп) (assurance ?a0))
	(fact (id 45) (name человек) (assurance ?a1))
	?f<-(fact (id 110) (name больной) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_109_A
	(declare (salience 40))
	(fact (id 95) (name колесо) (assurance ?a0))
	(fact (id 90) (name шерсть) (assurance ?a1))
	(not (exists (fact (id 111) (name прялка) ) ))
	=>
	(assert (fact (id 111) (name прялка)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Колесо + Шерсть = Прялка|прялка|"))
	(halt)
)
(defrule Rule_109_B
	(declare (salience 50))
	(fact (id 95) (name колесо) (assurance ?a0))
	(fact (id 90) (name шерсть) (assurance ?a1))
	?f<-(fact (id 111) (name прялка) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_110_A
	(declare (salience 40))
	(fact (id 79) (name планктон) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	(not (exists (fact (id 112) (name ракушки) ) ))
	=>
	(assert (fact (id 112) (name ракушки)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Планктон + Камень = Ракушки|ракушки|"))
	(halt)
)
(defrule Rule_110_B
	(declare (salience 50))
	(fact (id 79) (name планктон) (assurance ?a0))
	(fact (id 13) (name камень) (assurance ?a1))
	?f<-(fact (id 112) (name ракушки) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_111_A
	(declare (salience 40))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	(not (exists (fact (id 113) (name бумага) ) ))
	=>
	(assert (fact (id 113) (name бумага)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Давление + Древесина = Бумага |бумага|"))
	(halt)
)
(defrule Rule_111_B
	(declare (salience 50))
	(fact (id 6) (name давление) (assurance ?a0))
	(fact (id 93) (name древесина) (assurance ?a1))
	?f<-(fact (id 113) (name бумага) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_112_A
	(declare (salience 40))
	(fact (id 75) (name самолет) (assurance ?a0))
	(fact (id 14) (name металл) (assurance ?a1))
	(not (exists (fact (id 114) (name алюминий) ) ))
	=>
	(assert (fact (id 114) (name алюминий)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Самолет + Металл = Алюминий|алюминий|"))
	(halt)
)
(defrule Rule_112_B
	(declare (salience 50))
	(fact (id 75) (name самолет) (assurance ?a0))
	(fact (id 14) (name металл) (assurance ?a1))
	?f<-(fact (id 114) (name алюминий) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_113_A
	(declare (salience 40))
	(fact (id 114) (name алюминий) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	(not (exists (fact (id 115) (name зеркало) ) ))
	=>
	(assert (fact (id 115) (name зеркало)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Алюминий + Стекло = Зеркало|зеркало|"))
	(halt)
)
(defrule Rule_113_B
	(declare (salience 50))
	(fact (id 114) (name алюминий) (assurance ?a0))
	(fact (id 34) (name стекло) (assurance ?a1))
	?f<-(fact (id 115) (name зеркало) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_114_A
	(declare (salience 40))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 113) (name бумага) (assurance ?a1))
	(not (exists (fact (id 116) (name известняк) ) ))
	=>
	(assert (fact (id 116) (name известняк)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Камень + Ракушки = Известняк|известняк|"))
	(halt)
)
(defrule Rule_114_B
	(declare (salience 50))
	(fact (id 13) (name камень) (assurance ?a0))
	(fact (id 113) (name бумага) (assurance ?a1))
	?f<-(fact (id 116) (name известняк) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_115_A
	(declare (salience 40))
	(fact (id 42) (name бактерии) (assurance ?a0))
	(fact (id 99) (name виноград) (assurance ?a1))
	(not (exists (fact (id 117) (name вино) ) ))
	=>
	(assert (fact (id 117) (name вино)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Бактерии + Виноград = Вино|вино|"))
	(halt)
)
(defrule Rule_115_B
	(declare (salience 50))
	(fact (id 42) (name бактерии) (assurance ?a0))
	(fact (id 99) (name виноград) (assurance ?a1))
	?f<-(fact (id 117) (name вино) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_116_A
	(declare (salience 40))
	(fact (id 76) (name цветок) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	(not (exists (fact (id 118) (name фрукт) ) ))
	=>
	(assert (fact (id 118) (name фрукт)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Цветок + Дерево = Фрукт |фрукт|"))
	(halt)
)
(defrule Rule_116_B
	(declare (salience 50))
	(fact (id 76) (name цветок) (assurance ?a0))
	(fact (id 61) (name дерево) (assurance ?a1))
	?f<-(fact (id 118) (name фрукт) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_117_A
	(declare (salience 40))
	(fact (id 68) (name птица) (assurance ?a0))
	(fact (id 84) (name грипп) (assurance ?a1))
	(not (exists (fact (id 119) (name птичий_грипп) ) ))
	=>
	(assert (fact (id 119) (name птичий_грипп)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Птица + Грипп = Птичий грипп|птичий грипп|"))
	(halt)
)
(defrule Rule_117_B
	(declare (salience 50))
	(fact (id 68) (name птица) (assurance ?a0))
	(fact (id 84) (name грипп) (assurance ?a1))
	?f<-(fact (id 119) (name птичий_грипп) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_118_A
	(declare (salience 40))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	(not (exists (fact (id 92) (name сауна) ) ))
	=>
	(assert (fact (id 92) (name сауна)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Человек + Пар = Сауна|сауна|"))
	(halt)
)
(defrule Rule_118_B
	(declare (salience 50))
	(fact (id 45) (name человек) (assurance ?a0))
	(fact (id 9) (name пар) (assurance ?a1))
	?f<-(fact (id 92) (name сауна) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_119_A
	(declare (salience 40))
	(fact (id 8) (name море) (assurance ?a0))
	(fact (id 11) (name вулкан) (assurance ?a1))
	(not (exists (fact (id 16) (name остров) ) ))
	=>
	(assert (fact (id 16) (name остров)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Вулкан + Море = Остров|остров|"))
	(halt)
)
(defrule Rule_119_B
	(declare (salience 50))
	(fact (id 8) (name море) (assurance ?a0))
	(fact (id 11) (name вулкан) (assurance ?a1))
	?f<-(fact (id 16) (name остров) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_120_A
	(declare (salience 40))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 62) (name уголь) (assurance ?a1))
	(not (exists (fact (id 27) (name энергия) ) ))
	=>
	(assert (fact (id 27) (name энергия)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Уголь + Огонь = Энергия|энергия|"))
	(halt)
)
(defrule Rule_120_B
	(declare (salience 50))
	(fact (id 2) (name огонь) (assurance ?a0))
	(fact (id 62) (name уголь) (assurance ?a1))
	?f<-(fact (id 27) (name энергия) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_121_A
	(declare (salience 40))
	(fact (id 120) (name Максим_Галкин) (assurance ?a0))
	(fact (id 121) (name Алла_Пугачёва) (assurance ?a1))
	(not (exists (fact (id 122) (name Филипп_Киркоров_) ) ))
	=>
	(assert (fact (id 122) (name Филипп_Киркоров_)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " Алла Пугачёва + Максим Галкин = Филипп Киркоров|Филипп Киркоров |"))
	(halt)
)
(defrule Rule_121_B
	(declare (salience 50))
	(fact (id 120) (name Максим_Галкин) (assurance ?a0))
	(fact (id 121) (name Алла_Пугачёва) (assurance ?a1))
	?f<-(fact (id 122) (name Филипп_Киркоров_) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_122_A
	(declare (salience 40))
	(fact (id 111) (name прялка) (assurance ?a0))
	(fact (id 116) (name известняк) (assurance ?a1))
	(not (exists (fact (id 122) (name Филипп_Киркоров_) ) ))
	=>
	(assert (fact (id 122) (name Филипп_Киркоров_)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " прялка + известняк = Филипп Киркоров|Филипп Киркоров |"))
	(halt)
)
(defrule Rule_122_B
	(declare (salience 50))
	(fact (id 111) (name прялка) (assurance ?a0))
	(fact (id 116) (name известняк) (assurance ?a1))
	?f<-(fact (id 122) (name Филипп_Киркоров_) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_123_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	(not (exists (fact (id 125) (name нутелла) ) ))
	=>
	(assert (fact (id 125) (name нутелла)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " вода + огонь = нутелла|нутелла|"))
	(halt)
)
(defrule Rule_123_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 2) (name огонь) (assurance ?a1))
	?f<-(fact (id 125) (name нутелла) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

(defrule Rule_123_A
	(declare (salience 40))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	(not (exists (fact (id 125) (name нутелла) ) ))
	=>
	(assert (fact (id 125) (name нутелла)(assurance (* ?a0 ?a1))))
	(assert(sendmessagehalt " вода + земля = нутелла|нутелла|"))
	(halt)
)
(defrule Rule_123_B
	(declare (salience 50))
	(fact (id 1) (name вода) (assurance ?a0))
	(fact (id 3) (name земля) (assurance ?a1))
	?f<-(fact (id 125) (name нутелла) (assurance ?a))
	?newA<-(* ?a0 ?a1)
	(< ?a ?newA)
	=>
	(modify ?f (assurance ?newA))
	(halt)
)

