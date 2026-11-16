-- ============================================
-- CA1: SEED DATA FOR REVIEW AND COMMENT
-- Run after review_comment_tables.sql
-- Every review is on a product from that member's COMPLETED order.
-- ============================================

-- ============================================
-- SEED: review
-- ============================================
INSERT INTO public.review (id, member_id, product_id, rating, review_text, created_at, updated_at) VALUES
(1, 2, 1,  5, 'Keeps my water cold the whole day. Really happy with it.', '2025-01-10 09:12:00', '2025-01-10 09:12:00'),
(2, 3, 2,  4, 'Great insulation but a little heavy when full.',           '2025-01-15 20:03:00', '2025-01-15 20:03:00'),
(3, 4, 3,  3, 'Does the job. The lid is quite stiff to open.',            '2025-01-18 13:40:00', '2025-01-18 13:40:00'),
(4, 2, 5,  4, 'Good size for the gym.',                                   '2025-01-21 18:22:00', '2025-02-02 08:15:00'),
(5, 3, 11, 5, 'Awesome',                                                  '2025-04-26 16:30:16', '2025-04-26 16:30:16'),
(6, 4, 11, 1, 'poor',                                                     '2025-01-20 16:29:23', '2025-01-20 16:29:23'),
(7, 5, 4,  5, 'Light and easy to carry around.',                          '2025-01-25 11:05:00', '2025-01-25 11:05:00');

SELECT setval('public.review_id_seq', 7, true);

-- ============================================
-- SEED: comment
-- parent_comment_id NULL = top-level comment
-- ============================================
INSERT INTO public.comment (id, review_id, member_id, parent_comment_id, comment_text, is_deleted, created_at) VALUES
(1, 1, 3, NULL, 'How many hours does it stay cold for you?',        FALSE, '2025-01-11 10:00:00'),
(2, 1, 2, 1,    'Around 20 hours with ice.',                        FALSE, '2025-01-11 12:30:00'),
(3, 1, 3, 2,    'Nice, thanks!',                                    FALSE, '2025-01-11 13:02:00'),
(4, 1, 4, NULL, 'Is the lid dishwasher safe?',                      FALSE, '2025-01-12 08:45:00'),
(5, 2, 2, NULL, 'Which colour did you get?',                        TRUE,  '2025-01-16 09:00:00'),
(6, 2, 3, 5,    'The navy one!',                                    FALSE, '2025-01-16 11:20:00'),
(7, 6, 3, NULL, 'Mine has been fine, maybe you got a bad batch?',   FALSE, '2025-04-27 09:10:00'),
(8, 6, 4, 7,    'Could be, the seal leaked after a week.',          FALSE, '2025-04-27 14:48:00');

SELECT setval('public.comment_id_seq', 8, true);
