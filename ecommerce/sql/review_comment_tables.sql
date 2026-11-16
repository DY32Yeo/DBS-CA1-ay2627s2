-- ============================================
-- CA1: REVIEW AND COMMENT TABLES
-- Run after CreateDbTable.sql and SeedData.sql
-- ============================================

DROP TABLE IF EXISTS public.comment CASCADE;
DROP TABLE IF EXISTS public.review CASCADE;

-- ============================================
-- review
-- A member reviews a product they bought in a COMPLETED order.
-- One review per member per product (they update it instead of adding another).
-- ============================================
CREATE TABLE public.review (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    rating SMALLINT NOT NULL,
    review_text CHARACTER VARYING(500) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_review_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uq_review_member_product UNIQUE (member_id, product_id),
    CONSTRAINT fk_review_member FOREIGN KEY (member_id) REFERENCES public.member(id),
    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES public.product(id)
);

-- ============================================
-- comment
-- Belongs to one review. parent_comment_id is NULL for a top-level
-- comment, otherwise it points to the comment being replied to.
-- is_deleted keeps a deleted comment in place when it still has replies.
-- ============================================
CREATE TABLE public.comment (
    id SERIAL PRIMARY KEY,
    review_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    parent_comment_id INTEGER,
    comment_text CHARACTER VARYING(300) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_comment_review FOREIGN KEY (review_id) REFERENCES public.review(id) ON DELETE CASCADE,
    CONSTRAINT fk_comment_member FOREIGN KEY (member_id) REFERENCES public.member(id),
    CONSTRAINT fk_comment_parent FOREIGN KEY (parent_comment_id) REFERENCES public.comment(id) ON DELETE CASCADE
);
