DECLARE @ano INT, @semestre INT            

/*======================================
		MUDAR SEMESTRE E ANO
======================================*/
SET @ano = 20212021
SET @semestre = 2
--====================================--

USE [Moodle_Acad]

SELECT
	codigo_aluno,
	nome_aluno,
	serie,
	email,
	grupo_aluno,
	nota_aluno,
	[1] AS Q_1, [2] AS Q_2, [3] AS Q_3, [4] AS Q_4, [5] AS Q_5, [6] AS Q_6, [7] AS Q_7, [8] AS Q_8, [9] AS Q_9, [10] AS Q_10,
	[11] AS Q_11, [12] AS Q_12, [13] AS Q_13, [14] AS Q_14, [15] AS Q_15, [16] AS Q_16, [17] AS Q_17, [18] AS Q_18, [19] AS Q_19, [20] AS Q_20,
	[21] AS Q_21, [22] AS Q_22, [23] AS Q_23, [24] AS Q_24, [25] AS Q_25, [26] AS Q_26, [27] AS Q_27, [28] AS Q_28, [29] AS Q_29, [30] AS Q_30,
	[31] AS Q_31, [32] AS Q_32, [33] AS Q_33, [34] AS Q_34, [35] AS Q_35, [36] AS Q_36, [37] AS Q_37, [38] AS Q_38, [39] AS Q_39, [40] AS Q_40,
	[41] AS Q_41, [42] AS Q_42, [43] AS Q_43, [44] AS Q_44, [45] AS Q_45, [46] AS Q_46, [47] AS Q_47, [48] AS Q_48, [49] AS Q_49, [50] AS Q_50,
	[51] AS Q_51, [52] AS Q_52, [53] AS Q_53, [54] AS Q_54, [55] AS Q_55, [56] AS Q_56, [57] AS Q_57, [58] AS Q_58, [59] AS Q_59, [60] AS Q_60,
	[61] AS Q_61, [62] AS Q_62, [63] AS Q_63, [64] AS Q_64, [65] AS Q_65, [66] AS Q_66, [67] AS Q_67, [68] AS Q_68, [69] AS Q_69, [70] AS Q_70,
	[71] AS Q_71, [72] AS Q_72, [73] AS Q_73, [74] AS Q_74, [75] AS Q_75, [76] AS Q_76, [77] AS Q_77, [78] AS Q_78, [79] AS Q_79, [80] AS Q_80,
	[81] AS Q_81, [82] AS Q_82, [83] AS Q_83, [84] AS Q_84, [85] AS Q_85, [86] AS Q_86, [87] AS Q_87, [88] AS Q_88, [89] AS Q_89, [90] AS Q_90,
	[91] AS Q_91, [92] AS Q_92, [93] AS Q_93, [94] AS Q_94, [95] AS Q_95, [96] AS Q_96, [97] AS Q_97, [98] AS Q_98, [99] AS Q_99, [100] AS Q_100
FROM
(	SELECT
		CONCAT(u.firstname, ' ', u.lastname) AS nome_aluno,
		u.idnumber codigo_aluno,
		CONCAT(a.serie,'º ', a.turma) serie,                     -- série e turma do aluno
		u.email,											-- email aluno
		FORMAT(offr.sumgrades, 'N', 'pt-br') nota_aluno,	-- nota final
		offg.groupnumber grupo_aluno,
		qa.slot,											-- número da posição da questão que está no offlinequiz
		CASE 
			WHEN (qas.state = 'gradedright')
			THEN  '1'
			ELSE  '0'
		END resposta										--resposta do aluno
	
	FROM
		mdl_question_attempts qa
		INNER JOIN mdl_question_attempt_steps qas
			ON qa.id = qas.questionattemptid
		INNER JOIN mdl_question_usages qu
			ON qu.id = qa.questionusageid
		INNER JOIN mdl_context c
			ON c.id = qu.contextid
		INNER JOIN mdl_offlinequiz_results offr
			ON offr.usageid = qa.questionusageid
		INNER JOIN mdl_user u
			ON u.id = offr.userid
		INNER JOIN mdl_offlinequiz_group_questions offgq
			ON offgq.offlinequizid = offr.offlinequizid
			AND offgq.offlinegroupid = offr.offlinegroupid
			AND offgq.questionid = qa.questionid
		INNER JOIN mdl_offlinequiz_groups offg
			ON offg.id = offgq.offlinegroupid
		INNER JOIN Users.dbo.aluno a
			ON a.codigo_aluno = u.username
			AND a.ano_aluno = @ano
			AND a.semestre = @semestre
	WHERE
		qas.state != 'todo'
		AND qu.component LIKE 'mod_offlinequiz'
		AND c.instanceid = 297174
) AS SourceTable
PIVOT
(
	MAX(resposta)
	FOR slot IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				 [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				 [21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
				 [31], [32], [33], [34], [35], [36], [37], [38], [39], [40],
				 [41], [42], [43], [44], [45], [46], [47], [48], [49], [50],
				 [51], [52], [53], [54], [55], [56], [57], [58], [59], [60],
				 [61], [62], [63], [64], [65], [66], [67], [68], [69], [70],
				 [71], [72], [73], [74], [75], [76], [77], [78], [79], [80],
				 [81], [82], [83], [84], [85], [86], [87], [88], [89], [90],
				 [91], [92], [93], [94], [95], [96], [97], [98], [99], [100])
) AS pvt