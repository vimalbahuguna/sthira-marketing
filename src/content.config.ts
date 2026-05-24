import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const features = defineCollection({
  loader: glob({ pattern: '**/*.mdx', base: './src/content/features' }),
  schema: z.object({
    name: z.string(),
    tagline: z.string(),
    description: z.string(),
    accent: z.string().regex(/^#[0-9a-fA-F]{6}$/),
    category: z.enum(['planning', 'execution', 'compliance', 'visibility', 'intelligence']),
    bullets: z.array(z.string()).min(3).max(5),
    order: z.number().default(99),
  }),
});

export const collections = { features };
